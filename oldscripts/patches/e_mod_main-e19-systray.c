#include "e_mod_main.h"

static const char _Name[] = "Systray";
static const char _name[] = "systray";
static const char _group_gadget[] = "e/modules/systray/main";
static const char _sig_source[] = "e";

static E_Module *systray_mod = NULL;
static Systray_Context *ctx = NULL;
EINTERN Instance *instance = NULL; /* only one systray ever possible */
static char tmpbuf[4096]; /* general purpose buffer, just use immediately */

#define SYSTRAY_MIN_W 16
#define SYSTRAY_MIN_H 8

static Eina_Bool
_systray_site_is_safe(E_Gadcon_Site site)
{
   /* NB: filter out sites we know are not safe for a systray to sit.
    * This was done so that systray could be put into illume indicator
    * (or anywhere else really) that is 'safe' for systray to be.
    * Pretty much, this is anywhere but toolbars at the moment */
   return !e_gadcon_site_is_any_toolbar(site);
}

static const char *
_systray_theme_path(void)
{
#define TF "/e-module-systray.edj"
   unsigned int dirlen;
   const char *moddir = e_module_dir_get(systray_mod);

   dirlen = strlen(moddir);
   if (dirlen >= sizeof(tmpbuf) - sizeof(TF))
     return NULL;

   memcpy(tmpbuf, moddir, dirlen);
   memcpy(tmpbuf + dirlen, TF, sizeof(TF));

   return tmpbuf;
#undef TF
}


static void *
_cfg_data_create(E_Config_Dialog *cfd EINA_UNUSED)
{
   E_Config_Dialog_Data *cfdata = calloc(1, sizeof(E_Config_Dialog_Data));
   cfdata->use_xembed = ctx->config->use_xembed;
   return cfdata;
}

static void
_cfg_data_free(E_Config_Dialog *cfd EINA_UNUSED, E_Config_Dialog_Data *cfdata)
{
   free(cfdata);
}

static Evas_Object *
_cfg_widgets_create(E_Config_Dialog *cfd EINA_UNUSED, Evas *evas, E_Config_Dialog_Data *cfdata)
{
   Evas_Object *o, *of;
   o = e_widget_list_add(evas, 0, 0);

   return o;
}

static int
_cfg_data_apply(E_Config_Dialog *cfd, E_Config_Dialog_Data *cfdata)
{
   Instance *inst = cfd->data;
   if (ctx->config->use_xembed == cfdata->use_xembed)
     return 1;

   if (cfdata->use_xembed)
     {
        systray_xembed_init();
        inst->xembed = systray_xembed_new(inst);
     }
   else if (inst->xembed)
     {
        systray_xembed_free(inst->xembed);
        systray_xembed_shutdown();
        inst->xembed = NULL;
     }

   systray_size_updated(inst);

   ctx->config->use_xembed = cfdata->use_xembed;
   return 1;
}

static void
_cb_menu_cfg(void *data, E_Menu *m, E_Menu_Item *mi EINA_UNUSED)
{
   E_Config_Dialog_View *v;

   v = calloc(1, sizeof(E_Config_Dialog_View));
   v->create_cfdata = _cfg_data_create;
   v->free_cfdata = _cfg_data_free;
   v->basic.create_widgets = _cfg_widgets_create;
   v->basic.apply_cfdata = _cfg_data_apply;

   e_config_dialog_new(m->zone->comp, _("Systray Settings"), "E",
                       "_e_mod_systray_config_dialog",
                       NULL, 0, v, data);
}

static void
_systray_menu_new(Instance *inst, Evas_Event_Mouse_Down *ev)
{
   E_Zone *zone;
   E_Menu *m;
   E_Menu_Item *mi;
   int x, y;

   zone = e_util_zone_current_get(e_manager_current_get());

   m = e_menu_new();
   mi = e_menu_item_new(m);
   e_menu_item_label_set(mi, _("Settings"));
   e_util_menu_item_theme_icon_set(mi, "configure");
   e_menu_item_callback_set(mi, _cb_menu_cfg, inst);
   m = e_gadcon_client_util_menu_items_append(inst->gcc, m, 0);
   e_gadcon_canvas_zone_geometry_get(inst->gcc->gadcon, &x, &y, NULL, NULL);
   e_menu_activate_mouse(m, zone, x + ev->output.x, y + ev->output.y,
                         1, 1, E_MENU_POP_DIRECTION_AUTO, ev->timestamp);
   evas_event_feed_mouse_up(inst->gcc->gadcon->evas, ev->button,
                            EVAS_BUTTON_NONE, ev->timestamp, NULL);
}

static void
_systray_cb_mouse_down(void *data, Evas *evas __UNUSED__, Evas_Object *obj __UNUSED__, void *event __UNUSED__)
{
   Instance *inst = data;
   Evas_Event_Mouse_Down *ev = event;

   if (ev->button == 3)
     _systray_menu_new(inst, ev);
}

static void
_systray_theme(Evas_Object *o, const char *shelf_style, const char *gc_style)
{
   const char base_theme[] = "base/theme/modules/systray";
   const char *path = _systray_theme_path();
   char buf[128], *p;
   size_t len, avail;

   len = eina_strlcpy(buf, _group_gadget, sizeof(buf));
   if (len >= sizeof(buf))
     goto fallback;
   p = buf + len;
   *p = '/';
   p++;
   avail = sizeof(buf) - len - 2;

   if (shelf_style && gc_style)
     {
        size_t r;
        r = snprintf(p, avail, "%s/%s", shelf_style, gc_style);
        if (r < avail && e_theme_edje_object_set(o, base_theme, buf))
          return;
     }

   if (shelf_style)
     {
        size_t r;
        r = eina_strlcpy(p, shelf_style, avail);
        if (r < avail && e_theme_edje_object_set(o, base_theme, buf))
          return;
     }

   if (gc_style)
     {
        size_t r;
        r = eina_strlcpy(p, gc_style, avail);
        if (r < avail && e_theme_edje_object_set(o, base_theme, buf))
          return;
     }

   if (e_theme_edje_object_set(o, base_theme, _group_gadget))
     return;

   if (shelf_style && gc_style)
     {
        size_t r;
        r = snprintf(p, avail, "%s/%s", shelf_style, gc_style);
        if (r < avail && edje_object_file_set(o, path, buf))
          return;
     }

   if (shelf_style)
     {
        size_t r;
        r = eina_strlcpy(p, shelf_style, avail);
        if (r < avail && edje_object_file_set(o, path, buf))
          return;
     }

   if (gc_style)
     {
        size_t r;
        r = eina_strlcpy(p, gc_style, avail);
        if (r < avail && edje_object_file_set(o, path, buf))
          return;
     }

fallback:
   edje_object_file_set(o, path, _group_gadget);
}

static E_Gadcon_Client *
_gc_init(E_Gadcon *gc, const char *name, const char *id, const char *style)
{
   Instance *inst;

   // fprintf(stderr, "SYSTRAY: init name=%s, id=%s, style=%s\n", name, id, style);

   if (!systray_mod)
     return NULL;
   if ((!id) || (instance))
     {
        e_util_dialog_internal
          (_("Another systray exists"),
          _("There can be only one systray gadget and "
            "another one already exists."));
        return NULL;
     }

   inst = E_NEW(Instance, 1);
   if (!inst)
     return NULL;
   inst->evas = gc->evas;
   inst->comp = e_comp_get(NULL);
   if (!inst->comp)
     {
        E_FREE(inst);
        return NULL;
     }

   inst->ui.gadget = edje_object_add(inst->evas);

   _systray_theme(inst->ui.gadget, gc->shelf ? gc->shelf->style : NULL, style);

   inst->gcc = e_gadcon_client_new(gc, name, id, style, inst->ui.gadget);
   if (!inst->gcc)
     {
        evas_object_del(inst->ui.gadget);
        E_FREE(inst);
        return NULL;
     }
   e_gadcon_client_min_size_set(inst->gcc, SYSTRAY_MIN_W, SYSTRAY_MIN_H);

   inst->gcc->data = inst;

   evas_object_event_callback_add(inst->ui.gadget, EVAS_CALLBACK_MOUSE_DOWN,
                                  _systray_cb_mouse_down, inst);

   if (ctx->config->use_xembed)
     inst->xembed = systray_xembed_new(inst);
   inst->notifier = systray_notifier_host_new(inst, inst->gcc->gadcon);

   instance = inst;
   return inst->gcc;
}

/* Called when Gadget_Container says stop */
static void
_gc_shutdown(E_Gadcon_Client *gcc)
{
   Instance *inst = gcc->data;

   // fprintf(stderr, "SYSTRAY: shutdown %p, inst=%p\n", gcc, inst);

   if (!inst)
     return;

   if (inst->xembed)
     systray_xembed_free(inst->xembed);
   systray_notifier_host_free(inst->notifier);

   evas_object_del(inst->ui.gadget);

   if (instance == inst)
     instance = NULL;

   if (inst->job.size_apply)
     ecore_job_del(inst->job.size_apply);

   E_FREE(inst);
   gcc->data = NULL;
}

static void
_gc_orient(E_Gadcon_Client *gcc, E_Gadcon_Orient orient)
{
   Instance *inst = gcc->data;
   const char *sig;

   if (!inst)
     return;

   switch (orient)
     {
      case E_GADCON_ORIENT_FLOAT:
        sig = "e,action,orient,float";
        break;

      case E_GADCON_ORIENT_HORIZ:
        sig = "e,action,orient,horiz";
        break;

      case E_GADCON_ORIENT_VERT:
        sig = "e,action,orient,vert";
        break;

      case E_GADCON_ORIENT_LEFT:
        sig = "e,action,orient,left";
        break;

      case E_GADCON_ORIENT_RIGHT:
        sig = "e,action,orient,right";
        break;

      case E_GADCON_ORIENT_TOP:
        sig = "e,action,orient,top";
        break;

      case E_GADCON_ORIENT_BOTTOM:
        sig = "e,action,orient,bottom";
        break;

      case E_GADCON_ORIENT_CORNER_TL:
        sig = "e,action,orient,corner_tl";
        break;

      case E_GADCON_ORIENT_CORNER_TR:
        sig = "e,action,orient,corner_tr";
        break;

      case E_GADCON_ORIENT_CORNER_BL:
        sig = "e,action,orient,corner_bl";
        break;

      case E_GADCON_ORIENT_CORNER_BR:
        sig = "e,action,orient,corner_br";
        break;

      case E_GADCON_ORIENT_CORNER_LT:
        sig = "e,action,orient,corner_lt";
        break;

      case E_GADCON_ORIENT_CORNER_RT:
        sig = "e,action,orient,corner_rt";
        break;

      case E_GADCON_ORIENT_CORNER_LB:
        sig = "e,action,orient,corner_lb";
        break;

      case E_GADCON_ORIENT_CORNER_RB:
        sig = "e,action,orient,corner_rb";
        break;

      default:
        sig = "e,action,orient,horiz";
     }
   if (inst->xembed)
     systray_xembed_orient_set(inst->xembed, orient);

   edje_object_signal_emit(inst->ui.gadget, sig, _sig_source);
   edje_object_message_signal_process(inst->ui.gadget);
}

static const char *
_gc_label(const E_Gadcon_Client_Class *client_class __UNUSED__)
{
   return _("Systray");
}

static Evas_Object *
_gc_icon(const E_Gadcon_Client_Class *client_class __UNUSED__, Evas *evas)
{
   Evas_Object *o;

   o = edje_object_add(evas);
   edje_object_file_set(o, _systray_theme_path(), "icon");
   return o;
}

static const char *
_gc_id_new(const E_Gadcon_Client_Class *client_class __UNUSED__)
{
   return _name;
}

static const E_Gadcon_Client_Class _gc_class =
{
   GADCON_CLIENT_CLASS_VERSION, _name,
   {
      _gc_init, _gc_shutdown, _gc_orient, _gc_label, _gc_icon, _gc_id_new, NULL,
      _systray_site_is_safe
   },
   E_GADCON_CLIENT_STYLE_PLAIN
};

EAPI E_Module_Api e_modapi = {E_MODULE_API_VERSION, _Name};

EAPI void *
e_modapi_init(E_Module *m)
{
   systray_mod = m;

   ctx = calloc(1, sizeof(Systray_Context));
   ctx->conf_edd = E_CONFIG_DD_NEW("Systray_Config", Systray_Config);
   #undef T
   #undef D
   #define T Systray_Config
   #define D ctx->conf_edd
   E_CONFIG_VAL(D, T, use_xembed, INT);
   ctx->config = e_config_domain_load(_name, ctx->conf_edd);
   if (!ctx->config)
     ctx->config = calloc(1, sizeof(Systray_Config));

   e_gadcon_provider_register(&_gc_class);

   if (ctx->config->use_xembed)
     systray_xembed_init();
   systray_notifier_host_init();

   return ctx;
}

EAPI int
e_modapi_shutdown(E_Module *m __UNUSED__)
{
   e_gadcon_provider_unregister(&_gc_class);
   systray_mod = NULL;

   if (ctx->config->use_xembed)
     systray_xembed_shutdown();
   systray_notifier_host_shutdown();

   E_CONFIG_DD_FREE(ctx->conf_edd);
   free(ctx->config);
   free(ctx);
   return 1;
}

EAPI int
e_modapi_save(E_Module *m __UNUSED__)
{
   e_config_domain_save(_name, ctx->conf_edd, ctx->config);
   return 1;
}

E_Gadcon_Orient
systray_orient_get(const Instance *inst)
{
   EINA_SAFETY_ON_NULL_RETURN_VAL(inst, E_GADCON_ORIENT_HORIZ);
   return inst->gcc->gadcon->orient;
}

const E_Gadcon *
systray_gadcon_get(const Instance *inst)
{
   EINA_SAFETY_ON_NULL_RETURN_VAL(inst, NULL);
   return inst->gcc->gadcon;
}

E_Gadcon_Client *
systray_gadcon_client_get(const Instance *inst)
{
   EINA_SAFETY_ON_NULL_RETURN_VAL(inst, NULL);
   return inst->gcc;
}

const char *
systray_style_get(const Instance *inst)
{
   const char *style;

   EINA_SAFETY_ON_NULL_RETURN_VAL(inst, NULL);
   style = inst->gcc->style;
   if (!style)
     style = "default";
   return style;
}

Evas *
systray_evas_get(const Instance *inst)
{
   EINA_SAFETY_ON_NULL_RETURN_VAL(inst, NULL);
   return inst->evas;
}

Evas_Object *
systray_edje_get(const Instance *inst)
{
   EINA_SAFETY_ON_NULL_RETURN_VAL(inst, NULL);
   return inst->ui.gadget;
}

const Evas_Object *
systray_box_get(const Instance *inst)
{
   EINA_SAFETY_ON_NULL_RETURN_VAL(inst, NULL);
   return edje_object_part_object_get(inst->ui.gadget, "box");
}

void
systray_edje_box_append(const Instance *inst, Evas_Object *child)
{
   edje_object_part_box_append(inst->ui.gadget, "box", child);
}

void
systray_edje_box_prepend(const Instance *inst, Evas_Object *child)
{
   edje_object_part_box_prepend(inst->ui.gadget, "box", child);
}

void
systray_edje_box_remove(const Instance *inst, Evas_Object *child)
{
   edje_object_part_box_remove(inst->ui.gadget, "box", child);
}

int
systray_manager_number_get(const Instance *inst)
{
   EINA_SAFETY_ON_NULL_RETURN_VAL(inst, 0);
   return inst->comp->num;
}

Ecore_X_Window
systray_root_get(const Instance *inst)
{
   EINA_SAFETY_ON_NULL_RETURN_VAL(inst, 0);
   return inst->comp->man->root;
}

static void
_systray_size_apply_do(Instance *inst)
{
   Evas_Coord w, h;

   edje_object_message_signal_process(inst->ui.gadget);
   edje_object_size_min_calc(inst->ui.gadget, &w, &h);
   e_gadcon_client_min_size_set(inst->gcc, MAX(w, SYSTRAY_MIN_W), MAX(h, SYSTRAY_MIN_H));

   if (inst->xembed)
     systray_xembed_size_updated(inst->xembed);
}

static void
_systray_size_apply_delayed(void *data)
{
   Instance *inst = data;
   _systray_size_apply_do(inst);
   inst->job.size_apply = NULL;
}

void
systray_size_updated(Instance *inst)
{
   EINA_SAFETY_ON_NULL_RETURN(inst);
   if (inst->job.size_apply) return;
   inst->job.size_apply = ecore_job_add(_systray_size_apply_delayed, inst);
}

EINTERN Systray_Context *
systray_ctx_get(void)
{
   return ctx;
}

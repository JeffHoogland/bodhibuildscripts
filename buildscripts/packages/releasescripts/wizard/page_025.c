/*Theme Chooser*/
#include "e.h"
#include "e_mod_main.h"

static const char *theme = NULL;

static void
_theme_change(void *data, Evas_Object *obj, void *event_info __UNUSED__)
{
   Eina_List *selected;
   E_Fm2_Icon_Info *ici;
   Evas_Object *o = data;
   const char *realpath;
   char buf[4096];

   if (!(selected = e_widget_flist_selected_list_get(obj))) return;

   ici = selected->data;
   realpath = e_widget_flist_real_path_get(obj);

   if (!strcmp(realpath, "/"))
     snprintf(buf, sizeof(buf), "/%s", ici->file);
   else
     snprintf(buf, sizeof(buf), "%s/%s", realpath, ici->file);
   eina_list_free(selected);

   if (ecore_file_is_dir(buf) || !ecore_file_exists(buf)) return;

   if (theme)
     eina_stringshare_del(theme);
   theme = eina_stringshare_add(buf);
   e_widget_preview_edje_set(o, theme, "e/desktop/background");
   e_wizard_button_next_enable_set(1);  
}

EAPI int
wizard_page_init(E_Wizard_Page *pg __UNUSED__)
{
   return 1;
}

EAPI int
wizard_page_shutdown(E_Wizard_Page *pg __UNUSED__)
{
   eina_stringshare_del(theme);
   return 1;
}

EAPI int
wizard_page_show(E_Wizard_Page *pg)
{
   Evas_Object *o, *of, *oa, *ob, *oc;
   Evas_Object *flist, *textblock;
   char path[4096];

   o = e_widget_list_add(pg->evas, 1, 0);
   e_wizard_title_set(_("Theme"));
   
   of = e_widget_framelist_add(pg->evas, _("Choose A Theme"), 0);
   
   e_prefix_data_concat_static(path, "data/themes");

   ob = e_widget_flist_add(pg->evas);
   e_widget_size_min_set(ob, 140 * e_scale, 70 * e_scale);
   e_widget_flist_path_set(ob, path, "/");
   e_widget_framelist_object_append(of, ob);
   
   oa = e_widget_aspect_add(pg->evas, 280 * e_scale, 200 * e_scale);
   oc = e_widget_preview_add(pg->evas, 280 * e_scale, 200 * e_scale);
   e_widget_aspect_child_set(oa, oc);
   e_widget_framelist_object_append(of, oa);

   evas_object_smart_callback_add(ob, "selection_change", _theme_change, oc);

   e_widget_list_object_append(o, of, 1, 1, 0.5);

   evas_object_resize(oa, 140 * e_scale, 70 * e_scale);
   evas_object_show(oc);
   evas_object_show(oa);
   evas_object_show(ob);
   evas_object_show(of);
   e_wizard_page_show(o);
   pg->data = of;
   e_wizard_button_next_enable_set(0);

   return 1;
}

EAPI int
wizard_page_hide(E_Wizard_Page *pg)
{
   default_e_theme = eina_stringshare_add(theme);

   return 1;
}

EAPI int
wizard_page_apply(E_Wizard_Page *pg __UNUSED__)
{
   // no need. done in page_070's wizard_page_show()
   return 1;
}

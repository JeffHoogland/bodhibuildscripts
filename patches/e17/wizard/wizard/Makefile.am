MAINTAINERCLEANFILES = Makefile.in
MODULE = wizard

### dont install these - this way e wont list the module for people to
# accidentally load
#files_DATA = \
# e-module-$(MODULE).edj 
# module.desktop

EXTRA_DIST = $(files_DATA) $(desks_DATA)

# the module .so file
INCLUDES               = -I. \
                         -I$(top_srcdir) \
                         -I$(top_srcdir)/src/modules/$(MODULE) \
                         -I$(top_srcdir)/src/bin \
                         -I$(top_builddir)/src/bin \
                         -I$(top_srcdir)/src/modules \
                         @ECONNMAN_CFLAGS@ \
                         @e_cflags@ \
                         -I$(top_srcdir)/src/modules/comp
pkgdir                 = $(libdir)/enlightenment/modules/$(MODULE)/$(MODULE_ARCH)
pkg_LTLIBRARIES        = module.la \
                         page_000.la \
                         page_020.la \
                         page_025.la \
                         page_080.la \
                         page_200.la

module_la_SOURCES      = e_mod_main.c \
                         e_mod_main.h \
			 e_wizard.c \
                         e_wizard.h

module_la_LIBADD       = @e_libs@ @dlopen_libs@
module_la_LDFLAGS      = -module -avoid-version
module_la_DEPENDENCIES = $(top_builddir)/config.h

#Auto - Splash screen
page_000_la_SOURCES      = page_000.c
page_000_la_LIBADD       = @e_libs@ @dlopen_libs@
page_000_la_LDFLAGS      = -module -avoid-version
page_000_la_DEPENDENCIES = $(top_builddir)/config.h

#Choose Profile
page_020_la_SOURCES      = page_020.c
page_020_la_LIBADD       = @e_libs@ @dlopen_libs@
page_020_la_LDFLAGS      = -module -avoid-version
page_020_la_DEPENDENCIES = $(top_builddir)/config.h

#Choose Theme
page_025_la_SOURCES      = page_025.c
page_025_la_LIBADD       = @e_libs@ @dlopen_libs@
page_025_la_LDFLAGS      = -module -avoid-version
page_025_la_DEPENDENCIES = $(top_builddir)/config.h

#Auto Configures Launcher
page_080_la_SOURCES      = page_080.c
page_080_la_LIBADD       = @e_libs@ @dlopen_libs@
page_080_la_LDFLAGS      = -module -avoid-version
page_080_la_DEPENDENCIES = $(top_builddir)/config.h

#Auto - finish up applying
page_200_la_SOURCES      = page_200.c
page_200_la_LIBADD       = @e_libs@ @dlopen_libs@
page_200_la_LDFLAGS      = -module -avoid-version
page_200_la_DEPENDENCIES = $(top_builddir)/config.h

uninstall:
	rm -rf $(DESTDIR)$(libdir)/enlightenment/modules/$(MODULE)

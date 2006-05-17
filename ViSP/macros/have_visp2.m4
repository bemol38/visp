############################################################################
# Usage:
#   AC_HAVE_VISP2_IFELSE( IF-FOUND, IF-NOT-FOUND )
#
# Description:
#   This macro locates the ViSP2 development system.  If it is found,
#   the set of variables listed below are set up as described and made
#   available to the configure script.
#
# Autoconf Variables:
# > $ac_visp2_desired     true | false (defaults to true)
# < $ac_visp2_avail       true | false
# < $ac_visp2_cxxflags    (extra flags the C++ compiler needs)
# < $ac_visp2_ldflags     (extra flags the linker needs)
# < $ac_visp2_libs        (link library flags the linker needs)
#
# Author:
#   Fabien Spindler, <Fabien.Spindler@irisa.fr>
#
# TODO:
#



AC_DEFUN([AC_HAVE_VISP2_IFELSE], [
AC_PREREQ([2.14a])

# official variables
ac_visp2_avail=false
ac_visp2_cppflags=
ac_visp2_cflags=
ac_visp2_cxxflags=
ac_visp2_ldflags=
ac_visp2_libs=

# internal variables
ac_visp2_desired=true
ac_visp2_extrapath="/usr/bin"

AC_ARG_WITH([visp-install-bin],
AC_HELP_STRING([--with-visp-install-bin], [enable use of ViSP2 [[default=yes]]])
AC_HELP_STRING([--with-visp-install-bin=DIR], [give location of visp-config shell script (/usr/bin by default)]),
  [ case $withval in
    no)  ac_visp2_desired=false ;;
    yes) ac_visp2_desired=true ;;
    *)   ac_visp2_desired=true
         ac_visp2_extrapath=$withval ;;
    esac],
  [])

if $ac_visp2_desired; then
  ac_visp2_config_script="$ac_visp2_extrapath/visp-config"

  AC_CHECK_FILE($ac_visp2_config_script,[cv_visp2_avail=true],
                 [cv_visp2_avail=false])
  ac_visp2_avail=$cv_visp2_avail
fi

if $ac_visp2_avail; then
  ac_visp2_cflags="`$ac_visp2_config_script --cflags`"
  ac_visp2_libs="`$ac_visp2_config_script --libs`"
  ifelse([$1], , :, [$1])
else
  ifelse([$2], , :, [$2])
fi
]) # AC_HAVE_VISP2_IFELSE()


project('gatictactoe', ['c', 'vala'],
           version: '0.5.1',
     meson_version: '>= 0.59.0',
   default_options: [ 'warning_level=2',
       	            ],
)

pkgdata_dir = get_option('prefix') / get_option('datadir') / meson.project_name()

app_title = 'GaticTacToe'
app_summary = 'Play TicTacToe locally with your friends'

app_id = 'io.github.diegoivan.GaticTacToe'
app_name = meson.project_name()

conf_data = configuration_data()
conf_data.set('APP_ID', app_id)
conf_data.set('APP_PATH', '/' + app_id.replace('.', '/') + '/')
conf_data.set('APP_NAME', app_name)

conf_data.set('APP_TITLE', app_title)
conf_data.set('APP_SUMMARY', app_summary)

GaticTacToe_sources = []

valac = meson.get_compiler('vala')
vapi_dir = meson.project_source_root() / 'vapi'

# Dependencies

libadwaita_dep = dependency('libadwaita-1',
  version: '>= 1.0.0-alpha.2',
  required: false,
)

if not libadwaita_dep.found()
  libadwaita = subproject(
    'libadwaita',
    default_options: [
        'examples=false',
       f'package_subdir=@app_name@',
        'tests=false'
    ]
  )
  libadwaita_dep = declare_dependency(
    dependencies: [
        libadwaita.get_variable('libadwaita_dep'),
        libadwaita.get_variable('libadwaita_vapi')
    ]
  )
endif

GaticTacToe_deps = [
    dependency('gio-2.0', version: '>= 2.50'),
    dependency('gtk4', version: '>= 4.2'),
    libadwaita_dep,
    valac.find_library('config', dirs: vapi_dir),
]

i18n = import('i18n')

subdir('data')
subdir('resources')
subdir('src')
subdir('po')



gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
  update_desktop_database: true,
)

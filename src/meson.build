GaticTacToe_sources += [
  'Application.vala',

  'Models/Player.vala',

  'Widgets/Counter.vala',
  'Widgets/GridElement.vala',
  'Widgets/MainWindow.vala',
  'Widgets/WinnerPage.vala',
]

executable('gatictactoe', GaticTacToe_sources,
  vala_args: [
    '--target-glib=2.50',
    '--vapidir', vapi_dir,
    '--enable-experimental'
  ],
  c_args: [
    '-DVERSION="' + meson.project_version() + '"',
    '-DGETTEXT_PACKAGE="' + app_name + '"',
    '-DGNOMELOCALEDIR="' + get_option('prefix') / get_option('localedir') + '"',
    '-DAPP_ID="' + app_id + '"',
  ],
  dependencies: GaticTacToe_deps,
  install: true
)

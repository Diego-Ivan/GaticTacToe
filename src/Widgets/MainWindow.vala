namespace TicTacToe {
    [GtkTemplate (ui = "/ui/MainWindow.ui")]
    class MainWindow : Adw.ApplicationWindow {
        [GtkChild]
        private unowned Gtk.Label label;
        public MainWindow (Application app) {
            Object (
                application: app
            );
        }
    }
}

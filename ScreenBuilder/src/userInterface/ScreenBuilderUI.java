package userInterface;

/**
 *
 * @author Phil
 */
public class ScreenBuilderUI extends javax.swing.JFrame {

    /**
     * Creates new form ScreenBuilderUI
     */
    public ScreenBuilderUI() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        mainPane = new javax.swing.JSplitPane();
        sidebarPane = new javax.swing.JSplitPane();
        spritePane = new javax.swing.JScrollPane();
        propertyPane = new javax.swing.JScrollPane();
        propertyTable = new javax.swing.JTable();
        editorPane = new javax.swing.JScrollPane();
        mainMenuBar = new javax.swing.JMenuBar();
        fileMenu = new javax.swing.JMenu();
        fileImportItem = new javax.swing.JMenuItem();
        fileExportItem = new javax.swing.JMenuItem();
        editMenu = new javax.swing.JMenu();
        helpMenu = new javax.swing.JMenu();
        helpUsageItem = new javax.swing.JMenuItem();
        helpAboutItem = new javax.swing.JMenuItem();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Screen Builder");

        mainPane.setDividerLocation(500);

        sidebarPane.setDividerLocation(500);
        sidebarPane.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);
        sidebarPane.setTopComponent(spritePane);

        propertyTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Name", "Value"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, true
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        propertyPane.setViewportView(propertyTable);

        sidebarPane.setRightComponent(propertyPane);

        mainPane.setRightComponent(sidebarPane);
        mainPane.setLeftComponent(editorPane);

        fileMenu.setMnemonic('F');
        fileMenu.setText("File");

        fileImportItem.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_I, java.awt.event.InputEvent.CTRL_MASK));
        fileImportItem.setMnemonic('I');
        fileImportItem.setText("Import");
        fileMenu.add(fileImportItem);

        fileExportItem.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_E, java.awt.event.InputEvent.CTRL_MASK));
        fileExportItem.setMnemonic('E');
        fileExportItem.setText("Export");
        fileExportItem.setToolTipText("");
        fileMenu.add(fileExportItem);

        mainMenuBar.add(fileMenu);

        editMenu.setMnemonic('E');
        editMenu.setText("Edit");
        mainMenuBar.add(editMenu);

        helpMenu.setMnemonic('H');
        helpMenu.setText("Help");

        helpUsageItem.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_H, java.awt.event.InputEvent.CTRL_MASK));
        helpUsageItem.setMnemonic('H');
        helpUsageItem.setText("How to Use");
        helpMenu.add(helpUsageItem);

        helpAboutItem.setMnemonic('A');
        helpAboutItem.setText("About");
        helpMenu.add(helpAboutItem);

        mainMenuBar.add(helpMenu);

        setJMenuBar(mainMenuBar);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(mainPane, javax.swing.GroupLayout.DEFAULT_SIZE, 748, Short.MAX_VALUE)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(mainPane, javax.swing.GroupLayout.DEFAULT_SIZE, 715, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(ScreenBuilderUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(ScreenBuilderUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(ScreenBuilderUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(ScreenBuilderUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new ScreenBuilderUI().setVisible(true);
            }
        });
    }
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JMenu editMenu;
    private javax.swing.JScrollPane editorPane;
    private javax.swing.JMenuItem fileExportItem;
    private javax.swing.JMenuItem fileImportItem;
    private javax.swing.JMenu fileMenu;
    private javax.swing.JMenuItem helpAboutItem;
    private javax.swing.JMenu helpMenu;
    private javax.swing.JMenuItem helpUsageItem;
    private javax.swing.JMenuBar mainMenuBar;
    private javax.swing.JSplitPane mainPane;
    private javax.swing.JScrollPane propertyPane;
    private javax.swing.JTable propertyTable;
    private javax.swing.JSplitPane sidebarPane;
    private javax.swing.JScrollPane spritePane;
    // End of variables declaration//GEN-END:variables
}
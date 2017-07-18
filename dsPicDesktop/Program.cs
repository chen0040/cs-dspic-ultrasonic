using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace dsPicDesktop
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            dsPic.SerialPorts.SerialPortManager.ApplicationPath = Application.StartupPath;

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new frmDsPic());

            dsPic.SerialPorts.SerialPortManager.Instance.Release();
        }
    }
}
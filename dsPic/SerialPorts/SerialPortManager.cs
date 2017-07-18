using System;
using System.Collections.Generic;
using System.Text;
using System.IO.Ports;
using Wmi;
using Wmi.Hardware;
using System.Windows.Forms;

namespace dsPic.SerialPorts
{
    public sealed class SerialPortManager
    {
        private static SerialPortManager mInstance = null;
        private static object mLocker = new object();
        private List<HSerialPort> mPorts = new List<HSerialPort>();
        private List<HBaudRate> mBaudRates = new List<HBaudRate>();
        private List<HStopBits> mStopBits = new List<HStopBits>();
        private List<HParity> mParities = new List<HParity>();
        private List<HDataBits> mDataBits = new List<HDataBits>();
        private SerialPort mPort = null;
        private List<HPortListener> mPortListeners = new List<HPortListener>();
        private string mReadExisting = null;

        private HSerialPort mHSerialPort = null;
        public HSerialPort HSerialPort
        {
            get { return mHSerialPort; }
            set { mHSerialPort = value; }
        }

        private HBaudRate mHBaudRate = null;
        public HBaudRate HBaudRate
        {
            get { return mHBaudRate; }
            set { mHBaudRate = value; }
        }

        private HParity mHParity = null;
        public HParity HParity
        {
            get { return mHParity; }
            set { mHParity = value; }
        }

        private HDataBits mHDataBits;
        public HDataBits HDataBits
        {
            get { return mHDataBits; }
            set { mHDataBits = value; }
        }

        private HStopBits mHStopBits;
        public HStopBits HStopBits
        {
            get { return mHStopBits; }
            set { mHStopBits = value; }
        }

        private SerialPortManager()
        {
            Load();
        }

        public HBaudRate GetBaudRates(int baudrate)
        {
            foreach (HBaudRate rate in mBaudRates)
            {
                if (rate.Value == baudrate)
                {
                    return rate;
                }
            }
            return null;
        }

        public void AddPortListener(HPortListener listener)
        {
	        mPortListeners.Add(listener);
        }

        public HParity GetParity(Parity value)
        {
            foreach (HParity rate in mParities)
            {
                if (rate.Value == value)
                {
                    return rate;
                }
            }
            return null;
        }

        public HDataBits GetDataBits(int value)
        {
            foreach (HDataBits db in mDataBits)
            {
                if (db.Value == value)
                {
                    return db;
                }
            }
            return null;
        }

        public HStopBits GetStopBits(StopBits val)
        {
            foreach (HStopBits rate in mStopBits)
            {
                if (rate.Value == val)
                {
                    return rate;
                }
            }
            return null;
        }

        public List<HStopBits> StopBits
        {
            get
            {
                return mStopBits;
            }
        }

        public List<HDataBits> DataBits
        {
            get { return mDataBits; }
        }

        public List<HBaudRate> BaudRates
        {
            get
            {
                return mBaudRates;
            }
        }

        public List<HParity> Parities
        {
            get { return mParities; }
        }

        public string ReadExisting()
        {
            return mReadExisting;
        }

        public void Release()
        {
            if (mPort != null)
            {
                if (mPort.IsOpen)
                {
                    mPort.Close();
                }
            }
        }

        public bool Send(string message)
        {
            if (mPort != null && mPort.IsOpen)
            {
                mPort.Write(message);
                return true;
            }
            return false;
        }

        public bool Disconnect()
        {
            if (mPort != null)
            {
                if (mPort.IsOpen)
                {
                    mPort.Close();
                    return true;
                }
            }
            return false;
        }

        public SerialPort Connect()
        {
            string portName = this.HSerialPort.Name;
            int baudRate = this.HBaudRate.Value;
            Parity parity = this.HParity.Value;
            int dataBits = this.HDataBits.Value;
            StopBits stopBits = this.HStopBits.Value;

            if (mPort == null)
            {
                mPort = new SerialPort(portName, baudRate, parity, dataBits, stopBits);
            }
            else
            {
                if (mPort.IsOpen)
                {
                    mPort.Close();
                }
                mPort = new SerialPort(portName, baudRate, parity, dataBits, stopBits);
            }
            mPort.DataReceived += PortDataReceived;
            mPort.Open();
            return mPort;
        }

        private void PortDataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            mReadExisting = mPort.ReadExisting();
            foreach (HPortListener listener in mPortListeners)
            {
                listener.PortDataReceived();
            }
        }

        public void Load()
        {
            mPorts.Clear();
            mBaudRates.Clear();
            mStopBits.Clear();
            mParities.Clear();
            mDataBits.Clear();

            string[] port_names = SerialPort.GetPortNames();

            Connection.ApplicationPath = ApplicationPath;
            Connection wmiConnection = new Connection();

            Win32_SerialPortConfiguration x = new Win32_SerialPortConfiguration(wmiConnection);

            HSerialPort sp = new HSerialPort();
            foreach (string property in x.GetPropertyValues())
            {
                int split_index = property.IndexOf(": ");
                string property_name = property.Substring(0, split_index);
                string property_value = property.Substring(split_index + 2);

                if (property_name == HSerialPort.NAME_PROPERTY_ID && property_value != sp.Name)
                {
                    if (sp.Name == null)
                    {
                        sp.Name = property_value;
                    }
                    else
                    {
                        mPorts.Add(sp);
                        sp = new HSerialPort();
                    }



                    foreach (string port_name in port_names)
                    {
                        if (port_name == property_value)
                        {
                            sp.IsActive = true;
                            break;
                        }
                    }
                }

                sp[property_name] = property_value;
            }

            mBaudRates.Add(new HBaudRate(110));
            int baudrate = 300;
            for (int i = 0; i != 8; i++)
            {
                mBaudRates.Add(new HBaudRate(baudrate));
                baudrate *= 2;
            }
            mBaudRates.Add(new HBaudRate(14400));
            mBaudRates.Add(new HBaudRate(56000));
            mBaudRates.Add(new HBaudRate(57600));
            mBaudRates.Add(new HBaudRate(115200));
            mBaudRates.Add(new HBaudRate(128000));
            mBaudRates.Add(new HBaudRate(256000));

            mStopBits.Add(new HStopBits(System.IO.Ports.StopBits.None));
            mStopBits.Add(new HStopBits(System.IO.Ports.StopBits.One));
            mStopBits.Add(new HStopBits(System.IO.Ports.StopBits.OnePointFive));
            mStopBits.Add(new HStopBits(System.IO.Ports.StopBits.Two));

            mParities.Add(new HParity(System.IO.Ports.Parity.Even));
            mParities.Add(new HParity(System.IO.Ports.Parity.Mark));
            mParities.Add(new HParity(System.IO.Ports.Parity.None));
            mParities.Add(new HParity(System.IO.Ports.Parity.Odd));
            mParities.Add(new HParity(System.IO.Ports.Parity.Space));

            mDataBits.Add(new HDataBits(5));
            mDataBits.Add(new HDataBits(6));
            mDataBits.Add(new HDataBits(7));
            mDataBits.Add(new HDataBits(8));

            HBaudRate=GetBaudRates(14400);
            HStopBits = GetStopBits(System.IO.Ports.StopBits.One);
            HParity = GetParity(System.IO.Ports.Parity.None);
            HDataBits = GetDataBits(8);
        }

        public static string ApplicationPath
        {
            get
            {
                return Util.SysUtil.ApplicationPath;
            }
            set
            {
                Util.SysUtil.ApplicationPath = value;
            }
        }

        public static SerialPortManager Instance
        {
            get
            {
                if (mInstance == null)
                {
                    lock (mLocker)
                    {
                        mInstance = new SerialPortManager();
                    }
                }
                return mInstance;
            }
        }

        public List<HSerialPort> Ports
        {
            get
            {
                return mPorts;
            }
        }

        public List<HSerialPort> ActivePorts
        {
            get
            {
                List<HSerialPort> active_ports = new List<HSerialPort>();
                List<HSerialPort> port_grp = Ports;
                foreach (HSerialPort port in Ports)
                {
                    if (port.IsActive)
                    {
                        active_ports.Add(port);
                    }
                }
                return active_ports;
            }
        }
    }
}

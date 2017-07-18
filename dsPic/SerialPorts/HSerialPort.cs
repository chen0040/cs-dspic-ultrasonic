using System;
using System.Collections.Generic;
using System.Text;
using System.IO.Ports;

namespace dsPic.SerialPorts
{
    public class HSerialPort
    {
        private Dictionary<string, string> mProperties = new Dictionary<string, string>();
        private bool mActive = false;
        public static readonly string NAME_PROPERTY_ID = "Name"; //AttachedTo
        public SerialPort mPort = null;

        public string this[string index]
        {
            get { return mProperties[index]; }
            set { mProperties[index] = value; }
        }

        

        public string Name
        {
            get {
                if (mProperties.ContainsKey(NAME_PROPERTY_ID))
                {
                    return this[NAME_PROPERTY_ID];
                }
                else
                {
                    return null;
                }
            }
            set
            {
                mProperties[NAME_PROPERTY_ID] = value;
            }
        }

        public bool IsActive
        {
            get { return mActive; }
            set { mActive = value; }
        }

        public override string ToString()
        {
            if (IsActive)
            {
                return string.Format("{0}", Name);
            }
            return Name;
        }

        public string Description
        {
            get
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("+++++++++++++++++++++++++++++++++++++");
                foreach (string property_name in mProperties.Keys)
                {
                    sb.AppendFormat("\n{0}: {1}", property_name, mProperties[property_name]);
                }
                sb.Append("\n+++++++++++++++++++++++++++++++++++++");

                return sb.ToString();
            }
        }

        public string Html
        {
            get
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendFormat("<b>{0}</b>", Name);
                sb.Append("<table>");
                foreach (string property_name in mProperties.Keys)
                {
                    if (property_name != NAME_PROPERTY_ID)
                    {
                        sb.AppendFormat("<tr><td><font color=\"red\">{0}</font>: </td><td>{1}</td>", property_name, mProperties[property_name]);
                    }
                }
                sb.Append("</table>");

                return sb.ToString();
            }
        }
    }
}

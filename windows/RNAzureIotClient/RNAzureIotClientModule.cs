using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Azure.Iot.Client.RNAzureIotClient
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNAzureIotClientModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNAzureIotClientModule"/>.
        /// </summary>
        internal RNAzureIotClientModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNAzureIotClient";
            }
        }
    }
}

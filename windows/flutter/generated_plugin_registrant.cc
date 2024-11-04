//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <encrypt_decrypt_plus/encrypt_decrypt_plus_plugin_c_api.h>
#include <file_selector_windows/file_selector_windows.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  EncryptDecryptPlusPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("EncryptDecryptPlusPluginCApi"));
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
}

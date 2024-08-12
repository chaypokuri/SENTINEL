##### Imports #####

import "tfplan"
import "strings"

##### Functions #####

  resources = {}

  for tfplan.module_paths as path {
   
    for tfplan.module(path).resources[type] else {} as name, instances {
      
      for instances as index, r {
        
        if length(path) == 0 {
          
          address = type + "." + name + "[" + string(index) + "]"
        } else {
          
          address = "module." + strings.join(path, ".module.") + "." +
                    type + "." + name + "[" + string(index) + "]"
        }

                resources[address] = r
      }
    }
  }

  return resources
}

validate_attribute_in_list = func(type, attribute, allowed_values) {

  validated = true

  resource_instances = find_resources_from_plan(type)

  for resource_instances as address, r {

    if r.destroy and not r.requires_new {
      print("Skipping resource", address, "that is being destroyed.")
      continue
    }

    if r.diff[attribute].computed else false is true {
      print("Resource", address, "has attribute", attribute,
            "that is computed.")

    } else {
            if r.applied[attribute] else "" not in allowed_values {
        print("Resource", address, "has attribute", attribute, "with value",
              r.applied[attribute] else "",
              "that is not in the allowed list:", allowed_values)
        validated = false
      }
    }

  }
  return validated
}

allowed_sizes = [
  "Standard_A1",
  "Standard_A2",
  "Standard_D1_v2",
  "Standard_D2_v2",
]

vms_validated = validate_attribute_in_list("azurerm_virtual_machine", "vm_size", allowed_sizes)

main = rule {
  vms_validated
}

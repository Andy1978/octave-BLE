# von https://developer.bluetooth.org/gatt/services/Pages/ServicesHome.aspx
# 0x2902 Beschreibung in core.pdf Seite 2187, 2193

GATT_Services = {
  0x1800, "GAP_SERVICE", "Generic Access Profile";
  0x1801, "GATT_SERVICE", "Generic Attribute Profile";
  0x1811, "org.bluetooth.service.alert_notification", "Alert Notification Service";
  0x180F, "org.bluetooth.service.battery_service", "Battery Service";
  0x1810, "org.bluetooth.service.blood_pressure", "Blood Pressure";
  0x181B, "org.bluetooth.service.body_composition", "Body Composition";
  0x181E, "org.bluetooth.service.bond_management", "Bond Management";
  0x1805, "org.bluetooth.service.current_time", "Current Time Service";
  0x1818, "org.bluetooth.service.cycling_power", "Cycling Power";
  0x1816, "org.bluetooth.service.cycling_speed_and_cadence", "Cycling Speed and Cadence";
  0x180A, "org.bluetooth.service.device_information", "Device Information";
  0x1800, "org.bluetooth.service.generic_access", "Generic Access";
  0x1801, "org.bluetooth.service.generic_attribute", "Generic Attribute";
  0x1808, "org.bluetooth.service.glucose", "Glucose";
  0x1809, "org.bluetooth.service.health_thermometer", "Health Thermometer";
  0x180D, "org.bluetooth.service.heart_rate", "Heart Rate";
  0x1812, "org.bluetooth.service.human_interface_device", "Human Interface Device";
  0x1802, "org.bluetooth.service.immediate_alert", "Immediate Alert";
  0x1803, "org.bluetooth.service.link_loss", "Link Loss";
  0x1819, "org.bluetooth.service.location_and_navigation", "Location and Navigation";
  0x1807, "org.bluetooth.service.next_dst_change", "Next DST Change Service";
  0x180E, "org.bluetooth.service.phone_alert_status", "Phone Alert Status Service";
  0x1806, "org.bluetooth.service.reference_time_update", "Reference Time Update Service";
  0x1814, "org.bluetooth.service.running_speed_and_cadence", "Running Speed and Cadence";
  0x1813, "org.bluetooth.service.scan_parameters", "Scan Parameters";
  0x1804, "org.bluetooth.service.tx_power", "Tx Power";
  0x181C, "org.bluetooth.service.user_data", "User Data";
  0x181D, "org.bluetooth.service.weight_scale", "Weight Scale"};

GATT_Declarations = {
  0x2800, "GATT_PRIMARY_SERVICE", "Primary Service";
  0x2801, "GATT_SECONDARY_SERVICE", "Secondary Service";
  0x2802, "GATT_INCLUDE", "Include";
  0x2803, "GATT_CHARACTER", "Characteristic"};

GATT_Descriptors = {
  0x2900, "GATT_CHAR_EXT_PROPS_UUID", "Characteristic Extended Properties";
  0x2901, "GATT_CHAR_USER_DESC_UUID", "Characteristic User Description";
  0x2902, "GATT_CLIENT_CHAR_CFG_UUID", "Client Characteristic Configuration";
  0x2903, "GATT_SERV_CHAR_CFG_UUID", "Server Characteristic Configuration";
  0x2904, "GATT_CHAR_FORMAT_UUID", "Characteristic Presentation Format";
  0x2905, "GATT_CHAR_AGG_FORMAT_UUID", "Characteristic Aggregate Format";
  0x2906, "GATT_VALID_RANGE_UUID", "Valid Range";
  0x2907, "GATT_EXT_REPORT_REF_UUID", "External Report Reference Descriptor";
  0x2908, "GATT_REPORT_REF_UUID", "Report Reference Descriptor"};

GATT_Characteristics = {
  0x2A00, "DEVICE_NAME_UUID", "Device Name";
  0x2A01, "APPEARANCE_UUID", "Appearance";
  0x2A02, "PERI_PRIVACY_FLAG_UUID", "Peripheral Privacy Flag";
  0x2A03, "RECONNECT_ADDR_UUID", "Reconnection Address";
  0x2A04, "PERI_CONN_PARAM_UUID", "Peripheral Preferred Connection Parameters";
  0x2A05, "SERVICE_CHANGED_UUID", "Service Changed"};

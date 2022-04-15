resource "genesyscloud_telephony_providers_edges_site" "Primary_Site" {
  name                            = "Terraform Site"
  description                     = "test site description"
  location_id                     = genesyscloud_location.hq1.id
  media_model                     = "Cloud"
  media_regions_use_latency_based = true
  edge_auto_update_config {
    time_zone = var.timeZone
    rrule     = "FREQ=WEEKLY;BYDAY=SU"
    start     = "2021-08-08T08:00:00.000000"
    end       = "2021-08-08T11:00:00.000000"
  }
  /*number_plans {
    name           = "numberList plan"
    classification = "numberList classification"
    match_type     = "numberList"
  }
  number_plans {
    name           = "digitLength plan"
    classification = "digitLength classification"
    match_type     = "digitLength"
    digit_length {
      start = "6"
      end   = "8"
    }
  }*/
  outbound_routes {
    name                    = "Terraform route"
    description             = "outboundRoute description"
    classification_types    = ["International", "National", "Network", "Emergency"]
    external_trunk_base_ids = [data.genesyscloud_telephony_providers_edges_trunkbasesettings.trunkBaseSetting.id]
    distribution            = "RANDOM"
    enabled                 = true
  }

  /*outbound_routes {
    name                    = "outboundRoute 2"
    description             = "outboundRoute description"
    classification_types    = ["Network"]
    external_trunk_base_ids = [genesyscloud_telephony_providers_edges_trunkbasesettings.trunk-base-settings2.id]
    distribution            = "SEQUENTIAL"
    enabled                 = true
  }*/
}
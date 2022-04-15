terraform {
  required_version = "~> 1.1.6"
  required_providers {
    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = "~> 1.0.0"
    }
  }
}

provider "genesyscloud" {
  oauthclient_id = var.oauthclient_id
  oauthclient_secret = var.oauthclient_secret
  aws_region = var.aws_region
}

resource "genesyscloud_location" "hq1" {
  name  = "Indy"
  notes = "Main Indy Office"
  address {
    street1  = "7601 Interactive Way"
    city     = "Indianapolis"
    state    = "IN"
    country  = "US"
    zip_code = "46278"
  }
  emergency_number {
    number = "3173124657"
    type   = "default"
  }
}

resource "genesyscloud_telephony_providers_edges_phone" "test_phone" {
  name                   = "Terraform Phone"
  state                  = "active"
  site_id                = genesyscloud_telephony_providers_edges_site.Primary_Site.id
  phone_base_settings_id = genesyscloud_telephony_providers_edges_phonebasesettings.PhoneBaseSetting.id
  line_base_settings_id  = genesyscloud_telephony_providers_edges_phonebasesettings.PhoneBaseSetting.id
  //line_addresses         = ["+13175550000"]
  web_rtc_user_id        = "bb9bf39b-8e3f-4e1c-b9e5-05f06ad3574d"

  /*capabilities {
    provisions            = false
    registers             = false
    dual_registers        = false
    allow_reboot          = false
    no_rebalance          = false
    no_cloud_provisioning = false
    cdm                   = true
    hardware_id_type      = "mac"
    media_codecs          = ["audio/opus"]
  }*/
}

resource "genesyscloud_telephony_providers_edges_phonebasesettings" "PhoneBaseSetting" {
  name               = "Terraform webRTC"
  //description        = "test description"
  phone_meta_base_id = "inin_webrtc_softphone.json"
  properties = jsonencode({
   /* "phone_label" = {
      "value" = {
        "instance" = "Generic SIP Phone"
      }
    }
    "phone_maxLineKeys" = {
      "value" = {
        "instance" = 1
      }
    }
    "phone_mwi_enabled" = {
      "value" = {
        "instance" = true
      }
    }
    "phone_mwi_subscribe" = {
      "value" = {
        "instance" = true
      }
    }
    "phone_standalone" = {
      "value" = {
        "instance" = false
      }
    }*/
    "phone_stations" = {
      "value" = {
        "instance" = ["station 1"]
      }
    }
  })
}

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
    external_trunk_base_ids = data.genesyscloud_telephony_providers_edges_trunkBaseSetting.id
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
    external_trunk_base_ids = data.genesyscloud_telephony_providers_edges_trunkBaseSetting.id
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
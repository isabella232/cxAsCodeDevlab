terraform {
  required_version = "~> 1.1.6"
  required_providers {
    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = "~> 1.0.2"
    }
  }
}

provider "genesyscloud" {
  oauthclient_id = var.oauthclient_id
  oauthclient_secret = var.oauthclient_secret
  aws_region = var.aws_region
}

/*data "genesyscloud_auth_role" "Role" {
  name = "TerraformRole"
}*/

resource "genesyscloud_routing_skill" "skill" {
  name = "Terraform Skill"
}

resource "genesyscloud_user" "user" {
  email           = "terraform@example.com"
  name            = "Terraform guy"
  password        = "Terraform123!"
  //division_id     = genesyscloud_auth_division.home.id
  state           = "active"
  department      = "Development"
  title           = "Senior Director"
  //manager         = genesyscloud_user.test-user-manager.id
  acd_auto_answer = true
  profile_skills  = ["Java", "Go"]
  certifications  = ["Certified Developer"]
  addresses {
    other_emails {
      address = "john@gmail.com"
      type    = "HOME"
    }
    phone_numbers {
      number     = "3174181234"
      media_type = "PHONE"
      type       = "MOBILE"
    }
  }
  //could remove skills
  routing_skills {
    skill_id    = genesyscloud_routing_skill.skill.id
    proficiency = 4.5
  }
  /*routing_languages {
    language_id = genesyscloud_routing_language.english.id
    proficiency = 5
  }
  locations {
    location_id = genesyscloud_location.main-site.id
    notes       = "Office 201"
  }
  employer_info {
    official_name = "Jonathon Doe"
    employee_id   = "12345"
    employee_type = "Full-time"
    date_hire     = "2021-03-18"
  }
  routing_utilization {
    call {
      maximum_capacity = 1
      include_non_acd  = true
    }
    callback {
      maximum_capacity          = 2
      include_non_acd           = false
      interruptible_media_types = ["call", "email"]
    }
    chat {
      maximum_capacity          = 3
      include_non_acd           = false
      interruptible_media_types = ["call"]
    }
    email {
      maximum_capacity          = 2
      include_non_acd           = false
      interruptible_media_types = ["call", "chat"]
    }
    video {
      maximum_capacity          = 1
      include_non_acd           = false
      interruptible_media_types = ["call"]
    }
    message {
      maximum_capacity          = 4
      include_non_acd           = false
      interruptible_media_types = ["call", "chat"]
    }
  }*/
}

//This resources appears to not be working. Users will be created with Employee role and roles will need to be added manually until this is fixed
/*resource "genesyscloud_user_roles" "AssignRole" {
  user_id = "c6e8c01c-d953-446c-b37a-a2a5d78c81eb"
  roles {
    role_id      = "d24b8edc-10c7-4f57-b1ac-a75bafa5ff3b"
    //division_ids = [genesyscloud_auth_division.marketing.id]
  }
}*/

resource "genesyscloud_routing_wrapupcode" "wrapup_code" {
  name = "terraform wrap code"
}

resource "genesyscloud_routing_queue" "Queue" {
  name                              = "Terraform queue"
  //division_id                       = genesyscloud_auth_division.home.id
  description                       = "This is a test queue"
  acw_wrapup_prompt                 = "MANDATORY_TIMEOUT"
  acw_timeout_ms                    = 300000
  skill_evaluation_method           = "BEST"
  //queue_flow_id                     = data.genesyscloud_flow.queue-flow.id
  //whisper_prompt_id                 = data.genesyscloud_architect_user_prompt.whisper.id
  auto_answer_only                  = true
  //enable_transcription              = true
  enable_manual_assignment          = true
  calling_party_name                = "Example Inc."
  //outbound_messaging_sms_address_id = "c1bb045e-254d-4316-9d78-cea6849a3db4"
  /*outbound_email_address {
    domain_id = genesyscloud_routing_email_domain.main.id
    route_id  = genesyscloud_routing_email_route.support.id
  }*/
  media_settings_call {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.7
    service_level_duration_ms = 10000
  }
  routing_rules {
    operator     = "MEETS_THRESHOLD"
    threshold    = 9
    wait_seconds = 300
  }
  /*bullseye_rings {
    expansion_timeout_seconds = 15.1
    skills_to_remove          = [genesyscloud_routing_skill.test-skill.id]
  }*/
  /*default_script_ids = {
    EMAIL = data.genesyscloud_script.email.id
    CHAT  = data.genesyscloud_script.chat.id
  }*/
  members {
    user_id  = genesyscloud_user.user.id
    //ring_num = 2
  }
  wrapup_codes = [genesyscloud_routing_wrapupcode.wrapup_code.id]
}
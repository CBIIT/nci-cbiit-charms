/*****************************************************************************************/
/*********                  Family and Core Data                          ****************/
/*****************************************************************************************/
CREATE TABLE IF NOT EXISTS `lkup_protocol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` int NOT NULL,
  description varchar(150) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lkup_protocol_UNIQUE` (`id`),
  INDEX (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*****************************************************************************************/
/*********                  Family and Core Data                          ****************/
/*****************************************************************************************/


CREATE TABLE IF NOT EXISTS `family` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `referred_date` datetime DEFAULT NULL,
  `referral_source` int DEFAULT NULL,
  `branch` int DEFAULT NULL,
  `classification` varchar(3) DEFAULT NULL,
  `Investigator_Initials` varchar(45) DEFAULT NULL,
  `paper_file_location` varchar(3) DEFAULT NULL,
  `status` int DEFAULT '1',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `family_id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `core` (
  `id` int NOT NULL AUTO_INCREMENT,
  `family_id` int NOT NULL,
   /* ------------  */
  lastname  varchar(3) NOT NULL,
  firstname  varchar(3) NOT NULL,
  middlename  varchar(3) NOT NULL,
  `Title` int DEFAULT NULL,
   Suffix int DEFAULT NULL,
   `address1` varchar(120) DEFAULT NULL,
   `address2` varchar(120) DEFAULT NULL,
   `city` varchar(20) DEFAULT NULL,
   `state` varchar(2) DEFAULT NULL,
   `zip` varchar(9) DEFAULT NULL,
    `non_us_zip` varchar(10) DEFAULT NULL,
   `country` varchar(2) DEFAULT NULL, 
  /* ------------  */
	`sex` int NOT NULL,
	`dob` varchar(8) NOT NULL,
	`pregnancy_outcome` int DEFAULT NULL,
    `pregnancy_outcome_date` varchar(8) DEFAULT NULL,
	`vital_status` int NOT NULL,
	`last_status_date` varchar(8) DEFAULT NULL,
	death_city varchar(50) DEFAULT NULL,
	deatch_state varchar(2) DEFAULT NULL,
	death_county varchar(2) DEFAULT NULL,
	death_date varchar(8) DEFAULT NULL,
	death_cert_req_date varchar(8) DEFAULT NULL,
    death_cert_follow_up_date varchar(8) DEFAULT NULL,
    /* ------------  */  
    home_phone_country_code varchar(3) DEFAULT NULL,
    home_phone_city_code varchar(4) DEFAULT NULL,
	home_phone varchar(10) DEFAULT NULL,
    home_phone_extension varchar(4) DEFAULT NULL,
	work_phone_country_code varchar(3) DEFAULT NULL,
    work_phone_city_code varchar(4) DEFAULT NULL,
	work_phone varchar(10) DEFAULT NULL,
    work_phone_extension varchar(4) DEFAULT NULL,
	cell_phone_country_code varchar(3) DEFAULT NULL,
    cell_phone_city_code varchar(4) DEFAULT NULL,
	cell_phone varchar(10) DEFAULT NULL,
    cell_phone_extension varchar(4) DEFAULT NULL,
    fax_phone_country_code varchar(3) DEFAULT NULL,
    fax_phone_city_code varchar(4) DEFAULT NULL,
	fax_phone varchar(10) DEFAULT NULL,
	`email` varchar(80) DEFAULT NULL,
	contact int NOT NULL,
     /* ------------  */
     is_report_excluded  bit NOT NULL,
     mother_id int DEFAULT NULL,
     father_id int DEFAULT NULL,
     marital_status int DEFAULT NULL,
	 is_multiple_birth  bit DEFAULT NULL,
     `adoption` int DEFAULT NULL,
	/* ------------  */
	nih_number varchar(7) DEFAULT NULL,
	is_probacnd bit NOT NULL,  -- yes/No
    is_mailing bit NOT NULL,  -- yes/No
	informant int DEFAULT NULL,
    `relation` int NOT NULL,
	`ancestry_hispanic_latino` int NOT NULL,  
    `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_core_family_id_family_id` (`family_id`),
  KEY `fk_core_mother_id_core_id` (`mother_id`),
  KEY `fk_core_father_id_core_id` (`father_id`),
  CONSTRAINT `fk_core_family_id_family_id` FOREIGN KEY (`family_id`) REFERENCES `family` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_core_mother_id_core_id` FOREIGN KEY (`mother_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_core_father_id_core_id` FOREIGN KEY (`father_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS study (
  `id` int NOT NULL AUTO_INCREMENT,
  `family_id` int NOT NULL,
  `code` varchar(3) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `study_id_UNIQUE` (`id`),
  KEY `fk_study_family_id_family_id` (`family_id`),
  CONSTRAINT `fk_study_family_id_family_id` FOREIGN KEY (`family_id`) REFERENCES `family` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS protocol (
  id int NOT NULL AUTO_INCREMENT,
  core_id int NOT NULL,
  protocol_code int NOT NULL,   -- lkup_protocol
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `protocol_UNIQUE` (`id`),
  KEY `fk_protocol_core_id_core_id` (`core_id`),
  CONSTRAINT `fk_protocol_core_id_core_id` FOREIGN KEY (`core_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `multiple_birth` (
  `id` int NOT NULL AUTO_INCREMENT,
  `core_id` int NOT NULL,
  `multiple_birth_core_id` int NOT NULL,
    multiple_birth_type int NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `multiple_birth_UNIQUE` (`id`),
  KEY `fk_multiple_birth_core_id_core_id` (`core_id`),
  KEY `fk_multiple_birth_multiple_birth_core_id_core_id` (`multiple_birth_core_id`), 
  CONSTRAINT `fk_multiple_birth_core_id_core_id` FOREIGN KEY (`core_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_multiple_birth_multiple_birth_core_id_core_id` FOREIGN KEY (`multiple_birth_core_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS race (
  `id` int NOT NULL AUTO_INCREMENT,
  `core_id` int NOT NULL,
  `race` int NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `race_UNIQUE` (`id`),
  KEY `fk_race-core_id_core_id` (`core_id`),
  CONSTRAINT `core_id_core_id` FOREIGN KEY (`core_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS race (
  `id` int NOT NULL AUTO_INCREMENT,
  `core_id` int NOT NULL,
  `race` int NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `race_UNIQUE` (`id`),
  KEY `fk_race_core_id_core_id` (`core_id`),
  CONSTRAINT `core_id_core_id` FOREIGN KEY (`core_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS ethnic (
  `id` int NOT NULL AUTO_INCREMENT,
  `core_id` int NOT NULL,
  `ethnic` int NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ethnic_UNIQUE` (`id`),
  KEY `fk_ethnic_core_id_core_id` (`core_id`),
  CONSTRAINT `fk_ethnic_core_id_core_id` FOREIGN KEY (`core_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS spouse (
  `id` int NOT NULL AUTO_INCREMENT,
  `core_id` int NOT NULL,
  `spouse_id` int NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `spouse_UNIQUE` (`id`),
  KEY `fk_spouse_core_id_core_id` (`core_id`),
  KEY `fk_spouse_spouse_id_core_id` (`spouse_id`),
  CONSTRAINT `fk_spouse_core_id_core_id` FOREIGN KEY (`core_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_spouse_spouse_id_core_id` FOREIGN KEY (`spouse_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS legacy_id (
  `id` int NOT NULL AUTO_INCREMENT,
  `core_id` int NOT NULL,
  `legacy_id` varchar(20) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `legacy_id_UNIQUE` (`id`),
  KEY `fk_legacy_id_core_id_core_id` (`core_id`),
  CONSTRAINT `fk_legacy_id_core_id_core_id` FOREIGN KEY (`core_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



/*****************************************************************************************/
/********* Form Data - Consent, Cancer, Non-Cancer, Mutational... Data    ****************/
/*****************************************************************************************/

CREATE TABLE IF NOT EXISTS amendment (
  `id` int NOT NULL AUTO_INCREMENT,
  `amendment_code` int NOT NULL,  -- -- ikup_admendment
  display_in_dropdown int NOT NULL,  -- ikup_yes_no_unk
  posted_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `amendment_id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS consent (
  `id` int NOT NULL AUTO_INCREMENT,
  `core_id` int NOT NULL,  -- id = family_id+core_id???
  `consent_code` int NOT NULL, -- ??? ikup_consent_type??? 
  amendment_id int NOT NULL,
  signed_by int DEFAULT NULL,  -- ikup_signed_by
  signed_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `consent_id_UNIQUE` (`id`),
  KEY `fk_consent_core_id_core_id` (`core_id`),
  KEY `fk_consent_amendment_id_admendent_id` (`amendment_id`),
  CONSTRAINT `fk_study_core_id_core_id` FOREIGN KEY (`core_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_consent_amendment_id_admendent_id` FOREIGN KEY (`amendment_id`) REFERENCES `amendment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS optional_study (
  `id` int NOT NULL AUTO_INCREMENT,  
  amendment_id int NOT NULL,
  title varchar(150) NOT NULL,
  study_number int NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `optional_study_id_UNIQUE` (`id`),
  KEY `fk_optional_study_amendment_id_admendent_id` (`amendment_id`),
  CONSTRAINT `fk_optional_study_amendment_id_admendent_id` FOREIGN KEY (`amendment_id`) REFERENCES `amendment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS cancer (
  `id` int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
 `number` int NOT NULL, -- ???
	date_of_diagnosis datetime NOT NULL,
	age_at_diagnosis int NULL,
  estimated_age_at_diagnosis int NULL,
  `type` int NULL,  -- lkup_cancer_type
	icd_o_3_site varchar(4) NOT NULL, -- lkup_icd_o_3_site, 4 chars? Not matching UI???

	icd_o_3_morphology varchar(5) NULL,  -- lkup_icd_o_3_morphology, 5 chars?
  behavior int NULL,  -- lkup_behavior, 1 digit?
	grade_tcell_bcell int NULL,  -- lkup_grade_tcell_bcell

	laterality int NULL,  -- lkup_laterality
	stage varchar(2) NULL,  -- lkup_stage
	diagnosis_method int NULL,  -- lkup_can_diag_method
	dead_end varchar(2) NULL,  -- lkup_dead_end
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cancer_id_UNIQUE` (`id`),
  KEY `fk_cancer_core_id_core_id` (`core_id`),
  CONSTRAINT `fk_cancer_core_id_core_id` FOREIGN KEY (`core_id`) REFERENCES `core` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS non_cancer (
  id int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
  `number` int NOT NULL, -- ???
  date_of_diagnosis datetime NOT NULL,
  age_at_diagnosis int NULL,
  estimated_age_at_diagnosis int NULL, 
	icd_10 varchar(5) NOT NULL, -- lkup_icd_10 5 chars? 
	laterality int NULL,  -- lkup_laterality
	diagnosis_method int NULL,  -- lkup_can_diag_method
	dead_end varchar(2) NULL,  -- lkup_dead_end
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY non_cancer_id_UNIQUE (id),
  KEY fk_non_cancer_core_id_core_id (core_id),
  CONSTRAINT fk_non_cancer_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `procedure` (
  id int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
  `number` int NOT NULL, -- ???
  date_of_procedure datetime NOT NULL,
  age_at_procedure int NULL,  -- calculated age based on date_of_diagnosis
  estimated_age_at_procedure int NULL, 
  icd_9_cm varchar(4) NOT NULL, -- lkup_icd_9_cm
  laterality int NULL,  -- lkup_laterality
  intent int NULL,  -- lkup_intent
  procedure_validation int NULL,  -- lkup_proc_validation
  dead_end varchar(2) NULL,  -- lkup_dead_end
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY procedure_id_UNIQUE (id),
  KEY fk_procedure_core_id_core_id (core_id),
  CONSTRAINT fk_procedure_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS pathology_tracking (
  id int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
  `number` int NOT NULL, -- ???
  clinic_name varchar(40) NULL,
	address varchar(120) NULL,
	city varchar(20) NULL,
	state varchar(2) NULL,  -- lkup_state
	zip varchar(9) NULL,
	non_us_zip varchar(10) NULL,
	country varchar(2) NULL,  -- lkup_country
  date_of_procedure datetime NOT NULL,
  physician_last_name varchar(25) NULL,
	physician_first_name varchar(20) NULL,
	physician_initial varchar(1) NULL,
  pathology_result int NULL,  -- lkup_results_request
  date_pathology_sent datetime NULL, 
	date_pathology_received datetime NULL,
	date_fss_requested datetime NULL,
  date_fss_received datetime NULL,
	reviewer int NULL,  -- lkup_reviewer
	blocks_requested int NULL,  -- lkup_no_yes
	blocks_received_num int NULL,
	blocks_retained_num int NULL,
	blocks_location int NULL,  -- lkup_location_blocks
	blocks_location_other varchar(50) NULL,
	slides_requested int NULL,  -- lkup_no_yes
	slides_received_num int NULL,
	slides_retained_num int NULL,
	slides_location int NULL,  -- lkup_location_slides
	slides_location_other varchar(50) NULL,
  hospital_path_number varchar(14) NULL,
  fss_report_number varchar(8) NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY pathology_tracking_id_UNIQUE (id),
  KEY fk_pathology_tracking_core_id_core_id (core_id),
  CONSTRAINT fk_pathology_tracking_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS physician (
  id int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
  last_name varchar(25) NULL,
	first_name varchar(20) NULL,
	middle_initial varchar(1) NULL,
	clinic_name varchar(40) NULL,
	address varchar(120) NULL,
	city varchar(20) NULL,
	state varchar(2) NULL,  -- lkup_state
	zip varchar(9) NULL,
	non_us_zip varchar(10) NULL,
	country varchar(2) NULL,  -- lkup_country
  phone_country_code varchar(3) NULL,
	phone_city_code varchar(4) NULL,
	phone_number varchar(10) NULL,
	fax_country_code varchar(3) NULL,
	fax_city_code varchar(4) NULL,
	fax_number varchar(10) NULL,
	email varchar(80) NULL,
  specialty int NULL,  -- lkup_specialty
	is_primary_care_giver bit NULL,  -- lkup_no_yes
	patient_number varchar(20) NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY physician_id_UNIQUE (id),
  KEY fk_physician_core_id_core_id (core_id),
  CONSTRAINT fk_physician_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE IF NOT EXISTS clinical (
  id int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
   -- history --
  date_of_exam datetime NOT NULL,
  age_at_exam int NULL,  -- calculated
	height int NULL,
	weight int NULL,
	melanoma_status_at_exam int NOT NULL,
	date_melanoma_diagnosis datetime NULL,
	preexisting_nevus int NULL,
	dysplastic_nevi int NOT NULL,
   -- physical Eaminaiton --   
	eye_color_chart int NULL,
	eye_color int NULL,
	hair_color int NULL,
	complexion int NULL,
	freckles int NULL,
	freckles_back int NULL,
	freckles_arm int NULL,
	solar_injury int NULL, -- lkup_solar_injury
	number_previous_moles int NULL,
	mole_pattern int NULL,
  dn int NOT NULL,
	dn_analysis int NOT NULL,
  -- Mole Characteristics --   
  mole_scalp int NULL,  -- lkup_mole_charact
	mole_face int NULL,
	mole_ear int NULL,
	mole_neck int NULL,
	mole_back int NULL,  -- lkup_mole_charact
	mole_chest int NULL,
	mole_breasts int NULL,
	mole_abdomen int NULL,  -- lkup_mole_charact
	mole_upper_arm int NULL,
	mole_forearm int NULL,
	mole_hand int NULL,
	mole_buttock int NULL,  -- lkup_mole_charact
	mole_thigh int NULL,
	mole_calf int NULL,
	mole_foot int NULL,
	mole_perineum int NULL,
	mole_pubic int NULL,  -- lkup_mole_charact

  lesions_sun_exposed_skin int NULL,
	lesions_have_halos int NULL,
	surface_characteristics int NULL,
	largest_lesion_size_a int NULL,
	largest_lesion_size_b int NULL,
	typical_mole_size int NULL,
	moles_neurotized int NULL,

-- Mole counts (NEVI >= 2mm in diameter) --  
	moles_face_gt2 int NULL,
	moles_neck_gt2 int NULL,
	moles_scalp_gt2 int NULL,
	moles_l_upper_arm_gt2 int NULL,
	moles_r_upper_arm_gt2 int NULL,
	moles_l_lower_arm_gt2 int NULL,
	moles_r_lower_arm_gt2 int NULL,
	moles_l_hand_gt2 int NULL,
	moles_r_hand_gt2 int NULL,
	moles_front_gt2 int NULL,
	moles_back_gt2 int NULL,
	moles_buttocks_gt2 int NULL,
	moles_l_upper_leg_gt2 int NULL,
	moles_r_upper_leg_gt2 int NULL,
	moles_l_lower_leg_gt2 int NULL,
	moles_r_lower_leg_gt2 int NULL,
	moles_l_foot_gt2 int NULL,
	moles_r_foot_gt2 int NULL,
	moles_total_gt2 int NULL,
  -- Mole counts (NEVI >= 5mm in all diameters) --  
  moles_face_gt5 int NULL,
	moles_neck_gt5 int NULL,
	moles_scalp_gt5 int NULL,
	moles_l_upper_arm_gt5 int NULL,
	moles_r_upper_arm_gt5 int NULL,
	moles_l_lower_arm_gt5 int NULL,
	moles_r_lower_arm_gt5 int NULL,
	moles_l_hand_gt5 int NULL,
	moles_r_hand_gt5 int NULL,
	moles_front_gt5 int NULL,
	moles_back_gt5 int NULL,
	moles_buttocks_gt5 int NULL,
	moles_l_upper_leg_gt5 int NULL,
	moles_r_upper_leg_gt5 int NULL,
	moles_l_lower_leg_gt5 int NULL,
	moles_r_lower_leg_gt5 int NULL,
  moles_l_foot_gt5 int NULL,
	moles_r_foot_gt5 int NULL,
	moles_total_gt5 int NULL,
-- Mole counts (DN >= 5mm in one dimension) -- 
	moles_dn_face_gt5_1d int NULL,
	moles_dn_neck_gt5_1d int NULL,
	moles_dn_scalp_gt5_1d int NULL,
	moles_dn_l_upper_arm_gt5_1d int NULL,
	moles_dn_r_upper_arm_gt5_1d int NULL,
	moles_dn_l_lower_arm_gt5_1d int NULL,
	moles_dn_r_lower_arm_gt5_1d int NULL,
	moles_dn_l_hand_gt5_1d int NULL,
	moles_dn_r_hand_gt5_1d int NULL,
	moles_dn_front_gt5_1d int NULL,
	moles_dn_back_gt5_1d int NULL,
	moles_dn_buttocks_gt5_1d int NULL,
	moles_dn_l_upper_leg_gt5_1d int NULL,
	moles_dn_r_upper_leg_gt5_1d int NULL,
	moles_dn_l_lower_leg_gt5_1d int NULL,
	moles_dn_r_lower_leg_gt5_1d int NULL,
	moles_dn_l_foot_gt5_1d int NULL,
	moles_dn_r_foot_gt5_1d int NULL,
	moles_dn_total_gt5_1d int NULL,
-- Mole counts (DN >= 5mm in all diameters) --  
	moles_dn_face_gt5_ad int NULL,
	moles_dn_neck_gt5_ad int NULL,
	moles_dn_scalp_gt5_ad int NULL,
	moles_dn_l_upper_arm_gt5_ad int NULL,
	moles_dn_r_upper_arm_gt5_ad int NULL,
	moles_dn_l_lower_arm_gt5_ad int NULL,
	moles_dn_r_lower_arm_gt5_ad int NULL,
	moles_dn_l_hand_gt5_ad int NULL,
	moles_dn_r_hand_gt5_ad int NULL,
	moles_dn_front_gt5_ad int NULL,
	moles_dn_back_gt5_ad int NULL,
	moles_dn_buttocks_gt5_ad int NULL,
	moles_dn_l_upper_leg_gt5_ad int NULL,
	moles_dn_r_upper_leg_gt5_ad int NULL,
	moles_dn_l_lower_leg_gt5_ad int NULL,
	moles_dn_r_lower_leg_gt5_ad int NULL,
	moles_dn_l_foot_gt5_ad int NULL,
	moles_dn_r_foot_gt5_ad int NULL,
	moles_dn_total_gt5_ad int NULL,
-- Mole counts (DN < 5mm in all diameters) --    
  moles_dn_face_lt5 int NULL,
	moles_dn_neck_lt5 int NULL,
	moles_dn_scalp_lt5 int NULL,
	moles_dn_l_upper_arm_lt5 int NULL,
	moles_dn_r_upper_arm_lt5 int NULL,
	moles_dn_l_lower_arm_lt5 int NULL,
	moles_dn_r_lower_arm_lt5 int NULL,
	moles_dn_l_hand_lt5 int NULL,
	moles_dn_r_hand_lt5 int NULL,
	moles_dn_front_lt5 int NULL,
	moles_dn_back_lt5 int NULL,
	moles_dn_buttocks_lt5 int NULL,
	moles_dn_l_upper_leg_lt5 int NULL,
	moles_dn_r_upper_leg_lt5 int NULL,
	moles_dn_l_lower_leg_lt5 int NULL,
	moles_dn_r_lower_leg_lt5 int NULL,
	moles_dn_l_foot_lt5 int NULL,
	moles_dn_r_foot_lt5 int NULL,
	moles_dn_total_lt5 int NULL,
  
  	/*????
  moles_head_neck int NULL,
	moles_back int NULL,
	moles_sides int NULL,
	moles_chest_abdomen int NULL,
	moles_breasts int NULL,
	moles_left_arm int NULL,
	moles_right_arm int NULL,
	moles_left_leg int NULL,
	moles_right_leg int NULL,
	moles_buttock int NULL,
	number_of_moles int NULL,
	moles_dn_head_neck int NULL,
	moles_dn_back int NULL,
	moles_dn_sides int NULL,
	moles_dn_chest_abdomen int NULL,
	moles_dn_breasts int NULL,
	moles_dn_left_arm int NULL,
	moles_dn_right_arm int NULL,
	moles_dn_left_leg int NULL,
	moles_dn_right_leg int NULL,
	moles_dn_buttock int NULL,
	number_of_dn_moles int NULL,*/

  -- Other Skin Abnormalities --
  actinic_keratoses int NULL,  -- lkup_skin_abnormality
	vitiligo int NULL,
	giant_hairy_nevus int NULL,
	other_congenital_nevus int NULL,
	basal_cell_carcinoma int NULL,
	squamous_cell_carcinoma int NULL,
	blue_nevus int NULL,
	spitz_tumor int NULL,
	hypomacules int NULL,
	cafe_au_lait_spots int NULL,
	seborrheic_keratoses int NULL,
	other_abnormalities int NULL,
	lesions_suspicious int NULL,
	additional_comments int NULL,  -- lkup_no_yes
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY clinical_id_UNIQUE (id),
  KEY fk_clinical_core_id_core_id (core_id),
  CONSTRAINT fk_clinical_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS mole_biopsy (
  id int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
  outside_pathology varchar(14) NULL,
  cp_prefix varchar(2) NULL,   -- lkup_cp_prefix
	cp_number varchar(14) NULL,
  date_of_biopsy datetime NOT NULL,
	age_at_biopsy numeric(5,2) NULL,   -- calculated	
	nevus_type int NOT NULL,   -- lkup_nevus_type
	site_of_nevus int NULL,    -- lkup_site_nevus
	dysplasia int NOT NULL,  -- lkup_dysplasia
	dysplasia_level int NULL,   -- lkup_dysplasia_level
	dysplastic_nevus int NULL,   -- lkup_dysplastic_nevus
  solar_elastosis int NULL,  -- lkup_solar_elastosis
  melanocytic_hyperplasia int NULL,  -- lkup_present
	host_response int NULL,   -- lkup_present
	borderline_melanoma int NULL,   -- lkup_no_yes_unk
	closeup_code int NULL,
	date_last_closeup datetime NULL, 
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY mole_biopsy_id_UNIQUE (id),
  KEY fk_mole_biopsy_core_id_core_id (core_id),
  CONSTRAINT fk_mole_biopsy_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS melanoma (
  id int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
  outside_pathology varchar(14) NULL,
  date_of_biopsy datetime NOT NULL,
	age_at_biopsy numeric(5,2) NULL,   -- calculated
  cp_prefix varchar(2) NULL,   -- lkup_cp_prefix
	cp_number varchar(14) NULL,
  -- "sequence" int2 NULL,   ????
  `period` int NOT NULL,  -- lkup_period
  melanoma_type int NOT NULL,  -- lkup_melanoma_type
	growth_phase int NULL,   -- lkup_growth_phase
	clark_level int NULL,  -- lkup_clark_level
	thickness decimal(3,2) NULL,
	site int NULL,    -- lkup_site
	precursor_nevus int NULL,   -- lkup_precursor_nevus
  mode_of_documentation int NULL,  -- lkup_mode_document
	cell_type int NULL,   -- lkup_cell_type
	scatter int NULL,   -- lkup_scatter
	nesting int NULL,   -- lkup_nesting
	mitotic_count decimal(3,1) NULL,
	til_infiltration int NULL,   -- lkup_til_infiltration
	pigment int NULL,   -- lkup_pigment
  maxpig int2 NULL,   -- lkup_maxpig
  solar_elastosis int NULL,  -- lkup_solar_elastosis
	regression int NULL,   -- lkup_present
	ulceration int NULL,    -- lkup_present
	estimated_survival int NULL,
	closeup_code int NULL,
	date_last_closeup datetime NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY melanoma_id_UNIQUE (id),
  KEY fk_melanoma_core_id_core_id (core_id),
  CONSTRAINT fk_melanoma_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS cll_cytometry (
  id int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
  sample_id int NULL,  -- 9 digits
  date_flow_performed datetime NOT NULL,
	date_specimen_drawn datetime NOT NULL,	
	flow_laboratory int NULL,  -- lkup_flow_laboratory
	sample_type int NOT NULL,   -- lkup_cytometry_type
  --  Results  
  wbc decimal(5,2) NULL,
	alc decimal(6,3) NULL,
	lymphocytes decimal(5,2) NULL,
	b_cells decimal(5,2) NULL,
	balc decimal(9,2) NULL,
	clonal_balc1 decimal(9,2) NULL,
	clonal_balc2 decimal(9,2) NULL,
  -- Kappa/Lambda Ratio
	kl_ratio_whole decimal(7,3) NULL,
	kl_ratio_clone1 decimal(7,3) NULL,
	kl_ratio_clone2 decimal(7,3) NULL,
	kl_ratio_other decimal(7,3) NULL,
	other_specified_ratio varchar(20) NULL,
  -- Diagnosis
  cll_diagnosis int NOT NULL,   -- lkup_cll_diagnosis
	other_specified_diagnosis varchar(40) NULL,
	comments_dx text NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY cll_cytometry_id_UNIQUE (id),
  KEY fk_cll_cytometry_core_id_core_id (core_id),
  CONSTRAINT fk_cll_cytometry_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE IF NOT EXISTS cll_case (
  id int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
  -- diagnosis
  date_reviewed datetime NOT NULL,
	reviewed_by int NULL,  -- lkup_initials
	is_cll boolean NOT NULL DEFAULT false,
	date_cll_dx datetime NULL,
	is_nhl boolean NOT NULL DEFAULT false,
	nhl_subtype varchar(40) NULL,
	date_nhl_dx datetime NULL,
	is_hodgkin_lymphoma boolean NOT NULL DEFAULT false,
	date_hodgkin_lymphoma_dx datetime NULL,
	is_multiple_myeloma bool NOT NULL DEFAULT false,
	date_multiple_myeloma_dx datetime NULL,
	other_lpd_precursors_cancers boolean NOT NULL DEFAULT false,
	other_lpd_precursors_cancers_spec varchar(40) NULL,
	date_other_lpd_precursors_cancers_dx datetime NULL,
  -- cell counts
  b_cell_count decimal(9,3) NOT NULL,  
  date_b_cell datetime NOT NULL, 
  is_b_cell_na boolean NOT NULL DEFAULT false,	
  alc decimal(9,3) NULL,
  date_alc datetime NULL, 
	is_alc_na boolean NOT NULL DEFAULT false,
	rai_stage int NOT NULL,  -- lkup_rai_stage
  --  Diagnosis established by
  is_flow_cytometry boolean NOT NULL DEFAULT false,
	date_flow_cytometry datetime NULL,
	is_lymph_node_biopsy boolean NOT NULL DEFAULT false,
	date_lymph_node_biopsy datetime NULL,
	is_bone_marrow_biopsy boolean NOT NULL DEFAULT false,
	date_bone_marrow_biopsy datetime NULL,
	is_biopsy_other_tissue boolean NOT NULL DEFAULT false,
	biopsy_other_tissue_spec varchar(40) NULL,
	date_biopsy_other_tissue datetime NULL,
	is_peripheral_blood_smear boolean NOT NULL DEFAULT false,
	date_peripheral_blood_smear datetime NULL,
  --  Ancillary information
	allogeneic_bone_marrow_transplant int NULL,  -- lkup_no_yes_ti
	date_allogeneic_bone_marrow_transplant datetime NULL,
	is_fish_na bool NOT NULL DEFAULT false,
	is_fish_tri_12 boolean NOT NULL DEFAULT false,
	is_fish_13q boolean NOT NULL DEFAULT false,
	is_fish_17p boolean NOT NULL DEFAULT false,
	is_fish_11q23 boolean NOT NULL DEFAULT false,
	is_fish_other boolean NOT NULL DEFAULT false,
	is_fish_normal boolean NOT NULL DEFAULT false,
	date_fish datetime NULL,
	mutation_status int NOT NULL,  -- lkup_mutation_status
	date_mutation_status datetime NULL,
	zap_70 int NULL,  -- lkup_pos_neg_na
	date_zap_70 datetime NULL,
	cd38 int NOT NULL,  -- lkup_pos_neg_na
	date_cd38 datetime NULL,
  cd49d int NOT NULL,   -- lkup_pos_neg_na
	date_cd49d datetime NULL,
	cll_treatment int NOT NULL,  -- lkup_no_yes_na
	date_cll_treatment_status datetime NULL,
	other_pertinent_information text NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY cll_case_id_UNIQUE (id),
  KEY fk_cll_case_core_id_core_id (core_id),
  CONSTRAINT fk_cll_case_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS cll_clinical (
  id int NOT NULL AUTO_INCREMENT,  
  core_id int NOT NULL,
  -- history
  date_visit datetime NOT NULL,
	reason_visit int NOT NULL,
	cll_status int NOT NULL,
	other_lpd int NULL,
	other_cancer varchar(40) NULL,
	other_cll_status varchar(40) NULL,
	location_encounter int NOT NULL,
	weight_lbs decimal(6,3) NULL,
	height_inches int NULL,
	sweats int NULL,
	sweats_occasional int NULL,
	sweats_night int NULL,
	sweats_soaking int NULL,
	sweats_menopause int NULL,
	early_satiety int NULL,
	fatigue int NULL,
	reactions_insects int NULL,
	bleeding int NULL,
	infections int NULL,
	igiv int NULL,
  -- Physical Examination
  blood_pressure_sys int NULL,
	blood_pressure_dia int NULL,
	pulse int NULL,
	respiration int NULL,
	conjunctiva int NULL,
	conjunctiva_pale int NULL,
	conjunctiva_injected int NULL,
	lacrimal_glands int NULL,
	fundal_vessels int NULL,
	liver int NULL,
	spleen int NULL,
	tonsils_left int NULL,
	tonsils_right int NULL,
	epitrochlear_left int NULL,
	epitrochlear_right int NULL,
	anterior_cervical_left int NULL,
	anterior_cervical_right int NULL,
	posterior_cervical_left int NULL,
	posterior_cervical_right int NULL,
	supraclavicular_left int NULL,
	supraclavicular_right int NULL,
	infraclavicular_left int NULL,
	infraclavicular_right int NULL,
	axillary_left int NULL,
	axillary_right int NULL,
	inguinal_left int NULL,
	inguinal_right int NULL,
	lymph_other_1_spec varchar(30) NULL,
	lymph_other_1 int NULL,
	lymph_other_2_spec varchar(30) NULL,
	lymph_other_2 int NULL,
	lymph_other_3_spec varchar(30) NULL,
	lymph_other_3 int NULL,
	cardiac int NULL,
	pulmonary int NULL,
	abdomen int NULL,
	extremities int NULL,
	skin int NULL,
	nervous_system int NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY clinic_log_id_UNIQUE (id),
  KEY fk_clinic_log_core_id_core_id (core_id),
  CONSTRAINT fk_clinic_log_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- rename clinic_log to clinic_visit
CREATE TABLE IF NOT EXISTS clinic_visit (
  id int NOT NULL AUTO_INCREMENT,   -- replace with visit_id
  core_id int NOT NULL,
  -- visit_id int NOT NULL,  --  how does this get generated???
	date_visit datetime NOT NULL,
	clinic varchar(8) NULL,  -- ???
  state int NULL,  -- lkup_state
	country int NULL,  -- lkup_country
	new_patient int NOT NULL,  -- lkup_no_yes_cancelled
	study_code int NULL,  -- lkup_study_identifier
	md int NULL,  -- lkup_initials
	rn int NULL,  -- lkup_initials
	rn2 int NULL,  -- lkup_initials
  long_distance int NULL,  -- lkup_no_yes
	genetic_counselor int NULL,  -- lkup_genetic_counselor
	social_worker varchar(3) NULL,  -- lkup_social_worker
	blood int NULL,  -- lkup_no_yes
	skin int NULL,   -- lkup_no_yes
  money_source int NOT NULL,  -- lkup_money_source
  voucher int NULL,   -- lkup_no_yes
	voucher_cost decimal(10,2) NULL,
	travel int NULL,  -- lkup_no_yes
	travel_cost decimal(10,2) NULL,
	comments varchar(255) NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY clinic_visit_id_UNIQUE (id),
  KEY fk_clinic_visit_core_id_core_id (core_id),
  CONSTRAINT fk_clinic_visit_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS clinic_visit_protocol (
  	id int NOT NULL AUTO_INCREMENT,  
  	-- core_id int NOT NULL,  -- do we need this?
  	clinic_visit_id int NOT NULL,
  	protocol_code int NOT NULL,  -- lkup_protocol
  	created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	PRIMARY KEY (id),
  	UNIQUE KEY clinic_visit_protocolt_id_UNIQUE (id),
  	-- KEY fk_protocol_clinic_core_id_core_id (core_id), 
  	-- CONSTRAINT fk_protocol_clinic_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION,  
	KEY fk_clinic_visit_protocol_id_clinic_visit_id (clinic_visit_id),
   	KEY fk_clinic_visit_protocol_id_protocol_code (protocol_code),
    CONSTRAINT fk_clinic_visit_protocol_clinic_visit_id_clinic_visit_id FOREIGN KEY (clinic_visit_id) REFERENCES clinic_visit (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
   	CONSTRAINT fk_clinic_visit_protocol_clinic_visit_id_protocol_code FOREIGN KEY (protocol_code) REFERENCES lkup_protocol (code) ON DELETE NO ACTION ON UPDATE NO ACTION

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- rename field_trip_log to field_visit
CREATE TABLE IF NOT EXISTS field_visit (
	id int NOT NULL AUTO_INCREMENT,   -- used to be visit_id
  	core_id int NOT NULL,
	date_visit datetime NOT NULL,
	staff_travel int NOT NULL,
	new_patient int NOT NULL,  -- lkup_no_yes_cancelled
	study_code int NULL,  -- lkup_study_identifier
	md int NULL,  -- lkup_initials
	rn int NULL,  -- lkup_initials
	rn2 int NULL,  -- lkup_initials	
	genetic_counselor int NULL,  -- lkup_genetic_counselor
	social_worker varchar(3) NULL,  -- lkup_social_worker
	city varchar(20) NULL,
	state int NULL,  -- lkup_state
	country int NULL,  -- lkup_country
	blood int NULL,  -- lkup_no_yes
	skin int NULL,   -- lkup_no_yes
	comments varchar(255) NULL,
  	created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	PRIMARY KEY (id),
  	UNIQUE KEY field_visit_id_UNIQUE (id),
  	KEY fk_field_visit_core_id_core_id (core_id),
  	CONSTRAINT fk_field_visit_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS field_visit_protocol (
  	id int NOT NULL AUTO_INCREMENT,  
  	-- core_id int NOT NULL,  -- do we need this?
  	field_visit_id int NOT NULL,
	protocol_code int NOT NULL,  -- lkup_protocol
  	created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	PRIMARY KEY (id),
  	UNIQUE KEY field_visit_protocol_id_UNIQUE (id),
  	-- KEY fk_protocol_clinic_core_id_core_id (core_id),
  	KEY fk_ftvp_id_field_visit_id (field_visit_id),
	KEY fk_ftvp_protocol_code_protocol_code (protocol_code),   	
  	-- CONSTRAINT fk_protocol_clinic_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  	CONSTRAINT fk_ftvp_id_field_visit_id FOREIGN KEY (field_visit_id) REFERENCES field_visit (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  	CONSTRAINT fk_ftvp_protocol_code_protocol_code FOREIGN KEY (protocol_code) REFERENCES lkup_protocol (code) ON DELETE NO ACTION ON UPDATE NO ACTION

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS clinic_visit_protocol (
  	id int NOT NULL AUTO_INCREMENT,  
  	-- core_id int NOT NULL,  -- do we need this?
  	clinic_visit_id int NOT NULL,
  	protocol_code int NOT NULL,  -- lkup_protocol
  	created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	PRIMARY KEY (id),
  	UNIQUE KEY clinic_visit_protocolt_id_UNIQUE (id),
  	-- KEY fk_protocol_clinic_core_id_core_id (core_id), 
  	-- CONSTRAINT fk_protocol_clinic_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION,  
	KEY fk_clinic_visit_protocol_id_clinic_visit_id (clinic_visit_id),
   	KEY fk_clinic_visit_protocol_id_protocol_code (protocol_code),
    CONSTRAINT fk_clinic_visit_protocol_clinic_visit_id_clinic_visit_id FOREIGN KEY (clinic_visit_id) REFERENCES clinic_visit (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
   	CONSTRAINT fk_clinic_visit_protocol_clinic_visit_id_protocol_code FOREIGN KEY (protocol_code) REFERENCES lkup_protocol (code) ON DELETE NO ACTION ON UPDATE NO ACTION

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS genetic (
	id int NOT NULL AUTO_INCREMENT,  -- number??? 
	core_id int NOT NULL,
	source_of_test int NOT NULL,
	testing_laboratory int NOT NULL,
	validation_level int NOT NULL,
	date_sample_obtained datetime NOT NULL,
	date_of_report datetime NOT NULL,
	date_results_recorded datetime NOT NULL,	
	sample_id varchar(25) NULL,
	sample_type int NOT NULL,
	testing_type int NOT NULL,
	multi_gene_test varchar(100) NULL,
	-- gene_tested int2 NULL,  -- ???
	created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE KEY genetic_id_UNIQUE (id),
	KEY fk_genetic_core_id_core_id (core_id),
	CONSTRAINT fk_genetic_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS genetic_sample (
	id int NOT NULL AUTO_INCREMENT,  -- number??? 
    genetic_id INT NOT NULL,
	-- sample data pulled from BSI by sample_id
	family_specific_variant_test_1 int NULL,
	family_specific_variant_test_2 int NULL,
	family_specific_variant_test_3 int NULL,
	family_specific_variant_tested_1 varchar(200) NULL,
	family_specific_variant_tested_2 varchar(200) NULL,
	family_specific_variant_tested_3 varchar(200) NULL,
	variant_1_identified int NULL,
	variant_2_identified int NULL,
	variant_3_identified int NULL,
	variant_1_mosaic int NULL,
	variant_2_mosaic int NULL,
	variant_3_mosaic int NULL,
	variant_cdna_1 varchar(200) NULL,
	variant_cdna_2 varchar(200) NULL,
	variant_cdna_3 varchar(200) NULL,
	variant_protein_1 varchar(200) NULL,
	variant_protein_2 varchar(200) NULL,
	variant_protein_3 varchar(200) NULL,
	variant_gdna_1 varchar(200) NULL,
	variant_gdna_2 varchar(200) NULL,
	variant_gdna_3 varchar(200) NULL,
	variant_ncdna_1 varchar(200) NULL,
	variant_ncdna_2 varchar(200) NULL,
	variant_ncdna_3 varchar(200) NULL,
	variant_mtdna_1 varchar(200) NULL,
	variant_mtdna_2 varchar(200) NULL,
	variant_mtdna_3 varchar(200) NULL,
	variant_rna_1 varchar(200) NULL,
	variant_rna_2 varchar(200) NULL,
	variant_rna_3 varchar(200) NULL,
	variant_array_or_complex_1 varchar(200) NULL,
	variant_array_or_complex_2 varchar(200) NULL,
	variant_array_or_complex_3 varchar(200) NULL,
	variant_unknown_type_1 varchar(200) NULL,
	variant_unknown_type_2 varchar(200) NULL,
	variant_unknown_type_3 varchar(200) NULL,
	variant_exon_intron_1 varchar(35) NULL,
	variant_exon_intron_2 varchar(35) NULL,
	variant_exon_intron_3 varchar(35) NULL,
	variant_1_type int2 NULL,
	variant_2_type int2 NULL,
	variant_3_type int2 NULL,
	variant_1_interpretation int NULL,
	variant_2_interpretation int NULL,
	variant_3_interpretation int NULL,
	sequence_annotation_number_variant_1 varchar(35) NULL,
	sequence_annotation_number_variant_2 varchar(35) NULL,
	sequence_annotation_number_variant_3 varchar(35) NULL,
	original_laboratory_interpretation_variant_1 varchar(200) NULL,
	original_laboratory_interpretation_variant_2 varchar(200) NULL,
	original_laboratory_interpretation_variant_3 varchar(200) NULL,
	other_variants int NULL,
	notes varchar(500) NULL,
	multi_gene_test_gene_1 int NULL,
	multi_1_variant_1_identified int NULL,
	multi_1_variant_2_identified int NULL,
	multi_1_variant_3_identified int NULL,
	multi_1_variant_1_mosaic int NULL,
	multi_1_variant_2_mosaic int NULL,
	multi_1_variant_3_mosaic int NULL,
	multi_1_variant_cdna_1 varchar(200) NULL,
	multi_1_variant_cdna_2 varchar(200) NULL,
	multi_1_variant_cdna_3 varchar(200) NULL,
	multi_1_variant_protein_1 varchar(200) NULL,
	multi_1_variant_protein_2 varchar(200) NULL,
	multi_1_variant_protein_3 varchar(200) NULL,
	multi_1_variant_gdna_1 varchar(200) NULL,
	multi_1_variant_gdna_2 varchar(200) NULL,
	multi_1_variant_gdna_3 varchar(200) NULL,
	multi_1_variant_ncdna_1 varchar(200) NULL,
	multi_1_variant_ncdna_2 varchar(200) NULL,
	multi_1_variant_ncdna_3 varchar(200) NULL,
	multi_1_variant_mtdna_1 varchar(200) NULL,
	multi_1_variant_mtdna_2 varchar(200) NULL,
	multi_1_variant_mtdna_3 varchar(200) NULL,
	multi_1_variant_rna_1 varchar(200) NULL,
	multi_1_variant_rna_2 varchar(200) NULL,
	multi_1_variant_rna_3 varchar(200) NULL,
	multi_1_variant_array_or_complex_1 varchar(200) NULL,
	multi_1_variant_array_or_complex_2 varchar(200) NULL,
	multi_1_variant_array_or_complex_3 varchar(200) NULL,
	multi_1_variant_unknown_type_1 varchar(200) NULL,
	multi_1_variant_unknown_type_2 varchar(200) NULL,
	multi_1_variant_unknown_type_3 varchar(200) NULL,
	multi_1_variant_exon_intron_1 varchar(35) NULL,
	multi_1_variant_exon_intron_2 varchar(35) NULL,
	multi_1_variant_exon_intron_3 varchar(35) NULL,
	multi_1_variant_1_type int NULL,
	multi_1_variant_2_type int NULL,
	multi_1_variant_3_type int NULL,
	multi_1_variant_1_interpretation int NULL,
	multi_1_variant_2_interpretation int NULL,
	multi_1_variant_3_interpretation int NULL,
	multi_1_sequence_annotation_number_variant_1 varchar(35) NULL,
	multi_1_sequence_annotation_number_variant_2 varchar(35) NULL,
	multi_1_sequence_annotation_number_variant_3 varchar(35) NULL,
	multi_1_original_laboratory_interpretation_variant_1 varchar(200) NULL,
	multi_1_original_laboratory_interpretation_variant_2 varchar(200) NULL,
	multi_1_original_laboratory_interpretation_variant_3 varchar(200) NULL,
	multi_1_other_variants int NULL,
	multi_1_notes varchar(800) NULL,
	multi_gene_test_gene_2 int NULL,
	multi_2_variant_1_identified int NULL,
	multi_2_variant_2_identified int NULL,
	multi_2_variant_3_identified int NULL,
	multi_2_variant_1_mosaic int NULL,
	multi_2_variant_2_mosaic int NULL,
	multi_2_variant_3_mosaic int NULL,
	multi_2_variant_cdna_1 varchar(200) NULL,
	multi_2_variant_cdna_2 varchar(200) NULL,
	multi_2_variant_cdna_3 varchar(200) NULL,
	multi_2_variant_protein_1 varchar(200) NULL,
	multi_2_variant_protein_2 varchar(200) NULL,
	multi_2_variant_protein_3 varchar(200) NULL,
	multi_2_variant_gdna_1 varchar(200) NULL,
	multi_2_variant_gdna_2 varchar(200) NULL,
	multi_2_variant_gdna_3 varchar(200) NULL,
	multi_2_variant_ncdna_1 varchar(200) NULL,
	multi_2_variant_ncdna_2 varchar(200) NULL,
	multi_2_variant_ncdna_3 varchar(200) NULL,
	multi_2_variant_mtdna_1 varchar(200) NULL,
	multi_2_variant_mtdna_2 varchar(200) NULL,
	multi_2_variant_mtdna_3 varchar(200) NULL,
	multi_2_variant_rna_1 varchar(200) NULL,
	multi_2_variant_rna_2 varchar(200) NULL,
	multi_2_variant_rna_3 varchar(200) NULL,
	multi_2_variant_array_or_complex_1 varchar(200) NULL,
	multi_2_variant_array_or_complex_2 varchar(200) NULL,
	multi_2_variant_array_or_complex_3 varchar(200) NULL,
	multi_2_variant_unknown_type_1 varchar(200) NULL,
	multi_2_variant_unknown_type_2 varchar(200) NULL,
	multi_2_variant_unknown_type_3 varchar(200) NULL,
	multi_2_variant_exon_intron_1 varchar(35) NULL,
	multi_2_variant_exon_intron_2 varchar(35) NULL,
	multi_2_variant_exon_intron_3 varchar(35) NULL,
	multi_2_variant_1_type int NULL,
	multi_2_variant_2_type int NULL,
	multi_2_variant_3_type int NULL,
	multi_2_variant_1_interpretation int NULL,
	multi_2_variant_2_interpretation int NULL,
	multi_2_variant_3_interpretation int NULL,
	multi_2_sequence_annotation_number_variant_1 varchar(35) NULL,
	multi_2_sequence_annotation_number_variant_2 varchar(35) NULL,
	multi_2_sequence_annotation_number_variant_3 varchar(35) NULL,
	multi_2_original_laboratory_interpretation_variant_1 varchar(200) NULL,
	multi_2_original_laboratory_interpretation_variant_2 varchar(200) NULL,
	multi_2_original_laboratory_interpretation_variant_3 varchar(200) NULL,
	multi_2_other_variants int NULL,
	multi_2_notes varchar(800) NULL,
	multi_gene_test_gene_3 int NULL,
	multi_3_variant_1_identified int NULL,
	multi_3_variant_2_identified int NULL,
	multi_3_variant_3_identified int NULL,
	multi_3_variant_1_mosaic int NULL,
	multi_3_variant_2_mosaic int NULL,
	multi_3_variant_3_mosaic int NULL,
	multi_3_variant_cdna_1 varchar(200) NULL,
	multi_3_variant_cdna_2 varchar(200) NULL,
	multi_3_variant_cdna_3 varchar(200) NULL,
	multi_3_variant_protein_1 varchar(200) NULL,
	multi_3_variant_protein_2 varchar(200) NULL,
	multi_3_variant_protein_3 varchar(200) NULL,
	multi_3_variant_gdna_1 varchar(200) NULL,
	multi_3_variant_gdna_2 varchar(200) NULL,
	multi_3_variant_gdna_3 varchar(200) NULL,
	multi_3_variant_ncdna_1 varchar(200) NULL,
	multi_3_variant_ncdna_2 varchar(200) NULL,
	multi_3_variant_ncdna_3 varchar(200) NULL,
	multi_3_variant_mtdna_1 varchar(200) NULL,
	multi_3_variant_mtdna_2 varchar(200) NULL,
	multi_3_variant_mtdna_3 varchar(200) NULL,
	multi_3_variant_rna_1 varchar(200) NULL,
	multi_3_variant_rna_2 varchar(200) NULL,
	multi_3_variant_rna_3 varchar(200) NULL,
	multi_3_variant_array_or_complex_1 varchar(200) NULL,
	multi_3_variant_array_or_complex_2 varchar(200) NULL,
	multi_3_variant_array_or_complex_3 varchar(200) NULL,
	multi_3_variant_unknown_type_1 varchar(200) NULL,
	multi_3_variant_unknown_type_2 varchar(200) NULL,
	multi_3_variant_unknown_type_3 varchar(200) NULL,
	multi_3_variant_exon_intron_1 varchar(35) NULL,
	multi_3_variant_exon_intron_2 varchar(35) NULL,
	multi_3_variant_exon_intron_3 varchar(35) NULL,
	multi_3_variant_1_type int2 NULL,
	multi_3_variant_2_type int2 NULL,
	multi_3_variant_3_type int2 NULL,
	multi_3_variant_1_interpretation int NULL,
	multi_3_variant_2_interpretation int NULL,
	multi_3_variant_3_interpretation int NULL,
	multi_3_sequence_annotation_number_variant_1 varchar(35) NULL,
	multi_3_sequence_annotation_number_variant_2 varchar(35) NULL,
	multi_3_sequence_annotation_number_variant_3 varchar(35) NULL,
	multi_3_original_laboratory_interpretation_variant_1 varchar(200) NULL,
	multi_3_original_laboratory_interpretation_variant_2 varchar(200) NULL,
	multi_3_original_laboratory_interpretation_variant_3 varchar(200) NULL,
	multi_3_other_variants int NULL,
	multi_3_notes varchar(800) NULL,
	result varchar(100) NULL,
	interpretation int NULL,
	notes_cytogenetics varchar(500) NULL,
	complementation_group_identified int NULL,
	complementation_group int NULL,
	testing_completed int NULL,
	notes_complementation_group varchar(500) NULL,
	multi_gene_more_variants int NULL,
	single_notes varchar(800) NULL,
	date_updated timestamp NULL,
	disease_associated_gene bool NOT NULL DEFAULT false,
	multi_1_disease_associated_gene bool NOT NULL DEFAULT false,
	multi_2_disease_associated_gene bool NOT NULL DEFAULT false,
	multi_3_disease_associated_gene bool NOT NULL DEFAULT false,
	created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE KEY genetic_sample_id_UNIQUE (id),
	KEY fk_genetic_genetic_id_genetic_id (genetic_id),
	CONSTRAINT fk_genetic_sample_genetic_id_genetic_id FOREIGN KEY (genetic_id) REFERENCES genetic (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS cause_of_death (
	id int NOT NULL AUTO_INCREMENT,
	core_id int NOT NULL,
	cause_of_death1_icd10 varchar(5) NULL,
	cause_of_death1_icdo3_site varchar(4) NULL,
	cause_of_death1_icdo3_morph varchar(5) NULL,
	diagnosis_method1 int NULL,
	cause_of_death_level1 int NULL,
	cause_of_death2_icd10 varchar(5) NULL,
	cause_of_death2_icdo3_site varchar(4) NULL,
	cause_of_death2_icdo3_morph varchar(5) NULL,
	diagnosis_method2 int NULL,
	cause_of_death_level int2 NULL,
	cause_of_death3_icd10 varchar(5) NULL,
	cause_of_death3_icdo3_site varchar(4) NULL,
	cause_of_death3_icdo3_morph varchar(5) NULL,
	diagnosis_method3 int NULL,
	cause_of_death_level3 int2 NULL,
	created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE KEY cause_of_death_id_UNIQUE (id),
	KEY fk_cause_of_death_core_id_core_id (core_id),
	CONSTRAINT fk_cause_of_death_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*****************************************************************************************/
/******************               Event Managers                    **********************/
/*****************************************************************************************/

CREATE TABLE IF NOT EXISTS schedule (
  id int NOT NULL AUTO_INCREMENT,  
  name varchar(255) NOT NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY schedule_id_UNIQUE (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS schedule_event (
  id int NOT NULL AUTO_INCREMENT,  
  schedule_id int NOT NULL,
  sequence int NOT NULL,
  event_label varchar(50) NOT NULL,
  critical_window_length int NOT NULL,
  window_length int NOT NULL,
  is_initial_event bool NOT NULL,
  is_active bool NOT NULL,
  name varchar(255) NOT NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY schedule_id_UNIQUE (id),
  KEY fk_schedule_event_schedule_id_schedule_id (schedule_id),
  CONSTRAINT fk_schedule_event_schedule_id_schedule_id FOREIGN KEY (schedule_id) REFERENCES schedule (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS schedule_data (
  id int NOT NULL AUTO_INCREMENT,  
  schedule_id int NOT NULL,
  field_id numeric(10) NOT NULL,  -- data_fields
	choice_id numeric(10) NULL,   -- data_field_choices
  value varchar(255) NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY schedule_data_id_UNIQUE (id),
  KEY fk_schedule_data_schedule_id_schedule_id (schedule_id),
  CONSTRAINT fk_schedule_data_schedule_id_schedule_id FOREIGN KEY (schedule_id) REFERENCES schedule (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS schedule_event_data (
  id int NOT NULL AUTO_INCREMENT,  
  schedule_event_id int NOT NULL,
  field_id numeric(10) NOT NULL,  -- data_fields
	choice_id numeric(10) NULL,   -- data_field_choices
  value varchar(255) NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY schedule_event_data_id_UNIQUE (id),
  KEY fk_schedule_event_data_schedule_event_id_schedule_event_id (schedule_event_id),
  CONSTRAINT fk_schedule_event_data_schedule_event_id_schedule_event_id FOREIGN KEY (schedule_event_id) REFERENCES schedule_event (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS enrollment (
  id int NOT NULL AUTO_INCREMENT,  
  schedule_id int NOT NULL,
  core_id int NOT NULL,
  active int NOT NULL,   -- lkup_active
	comments text NULL,
  created_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY enrollment_id_UNIQUE (id),
  KEY fk_enrollment_schedule_id_schedule_id (schedule_id),
  KEY fk_enrollment_core_id_core_id (core_id),
  CONSTRAINT fk_enrollment_schedule_id_schedule_id FOREIGN KEY (schedule_id) REFERENCES schedule (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_enrollment_core_id_core_id FOREIGN KEY (core_id) REFERENCES core (id) ON DELETE NO ACTION ON UPDATE NO ACTION
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE DEFINER = 'root'@'localhost' TRIGGER `civicrm_membership_payment_before_ins_tr` BEFORE INSERT ON `civicrm_membership_payment`
  FOR EACH ROW

  UPDATE civicrm_membership
  	SET 
	 civicrm_membership.status_id =
     ( SELECT
     	CASE 
        	when contribution_status_id in (1) THEN 2
            when contribution_status_id in (2, 5) THEN 5
            else civicrm_membership.status_id
        END
        FROM civicrm_contribution cc
  		WHERE cc.id = NEW.contribution_id and
    		cc.contact_id = civicrm_membership.contact_id and
    		cc.contribution_status_id in (1, 2, 5)
     )
  where civicrm_membership.id = NEW.membership_id AND 
  	civicrm_membership.status_id in (6, 7) ;
    

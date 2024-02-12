trigger HastaTrigger on HASTA__c (before insert , before update , before delete , after insert , after update, 
after delete, after undelete) {

SWITCH on Trigger.operationType {
        WHEN BEFORE_INSERT  { }
        WHEN BEFORE_UPDATE  { }
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   {
/*  
        bir hastanede hastanin recordunu sadece hastanin doktoru ve hemsiresi gorebilir
       bir Hasta recordu olustugunda  hastain doktoru ve hemsiresi de recordu gorecek sekilde trigger olusturunuz
        */
           list<Hasta__Share> hastaSharingListesi = new List<Hasta__Share>(); 
             
              for(Hasta__c  hst: trigger.new ){
              // doctor ile paylasilan
       Hasta__Share paslasDoktor = HastaHandler.hastaSharing(hst.Id , hst.Dr_Ismi__c  );
       hastaSharingListesi.add(paslasDoktor);
           
                  // hemsire ile paylasma  
       Hasta__Share paslasHemsire =  HastaHandler.hastaSharing(hst.Id , hst.Hemsire_Ismi__c  );
       hastaSharingListesi.add(paslasHemsire);
               
            } 
         insert hastaSharingListesi;   
            
            
            
          /*  
            for(Hasta__c  hst: trigger.new ){
              // dotor ile paylasilan
                Hasta__Share paslasDoktor = new Hasta__Share();
                paslasDoktor.ParentId      = hst.id;
                paslasDoktor.UserOrGroupId = hst.Dr_Ismi__c;
               // paslasDoktor.UserOrGroupId  = hst.Hemsire_Ismi__c ; 
                paslasDoktor.AccessLevel = 'Edit';
                paslasDoktor.RowCause = 'Manual';
                
                hastaSharingListesi.add(paslasDoktor);
                
          // hemsire ile paylasma  
                        
              Hasta__Share paslasHemsire = new Hasta__Share();
                paslasHemsire.ParentId      = hst.id;
                //paslasHasta2.UserOrGroupId = hst.Dr_Ismi__c;
                paslasHemsire.UserOrGroupId  = hst.Hemsire_Ismi__c ; 
                paslasHemsire.AccessLevel = 'Edit';
                paslasHemsire.RowCause = 'Manual';  
                
               hastaSharingListesi.add(paslasHemsire);
  
            }
      insert hastaSharingListesi;
*/            
        
        }
        WHEN AFTER_UPDATE   { }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { }
    }
    
    
    
    
    
}
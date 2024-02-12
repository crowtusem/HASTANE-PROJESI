trigger HastaTrigger on HASTA__c (before insert , before update , before delete , after insert , after update, 
after delete, after undelete) {trigger HastaTrigger on HASTA__c (before insert , before update , before delete , after insert , after update, 
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
       Hasta__Share paslasDoktor = HastaHandler.hastaSharing(hst.id , hst.Dr_Ismi__c  );
       hastaSharingListesi.add(paslasDoktor);
           
                  // hemsire ile paylasma  
       Hasta__Share paslasHemsire =  HastaHandler.hastaSharing(hst.id , hst.Hemsire_Ismi__c  );
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
        WHEN AFTER_UPDATE   { 
            
            try{
                 // 1. asama eski recordlarin silinmesi
            list<id> hastaIdleri = new List<id>();
            list<id> doctorIdleri = new List<id>();
            list<id> hemsireIdleri = new List<id>();
            
            for(Hasta__c hst: trigger.old){
              
                hastaIdleri.add(hst.id); 
                if(hst.Dr_Ismi__c != null){
                    doctorIdleri.add(hst.Dr_Ismi__c);
                }
                if(hst.Hemsire_Ismi__c  != null){
                    hemsireIdleri.add(hst.Hemsire_Ismi__c);
                }
                
            }
        
            // SELECT Id, ParentId, UserOrGroupId, AccessLevel, RowCause FROM Hasta__Share
            
List<Hasta__Share> silinecekRecordlar = [SELECT Id FROM Hasta__Share  WHERE  ParentId IN:  hastaIdleri 
                                         AND ( UserOrGroupId IN: doctorIdleri OR UserOrGroupId IN:hemsireIdleri)];
        
        database.delete(silinecekRecordlar );
                
            }   
            catch(exception e){
              system.debug('Hata var ' + e.getMessage());  
            }finally {
                
                //  2. asama   yeni recordlarin insert edilmesi  
             list<Hasta__Share> hastaSharingListesi = new List<Hasta__Share>();
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
                
            }
            
            
       
        
          
        
        }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { }
 
    }
    
    
}
                          
                                      
                                      
                                      
                                 

										
       
														
    
    
    
    
}
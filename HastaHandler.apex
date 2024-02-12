public class HASTAHandler {

    public static Hasta__Share hastaSharing(Id hastaIdsi , Id PayalasilacakKisiId  ){
          
                Hasta__Share paslasDoktor = new Hasta__Share();
                paslasDoktor.ParentId      = hastaIdsi;
                paslasDoktor.UserOrGroupId = PayalasilacakKisiId;
         
                paslasDoktor.AccessLevel = 'Edit';
                paslasDoktor.RowCause = 'Manual';
          
  
        return paslasDoktor; 
    }
    
    
}
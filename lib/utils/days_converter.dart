String daysConverter(int days){
  int months=0,years=0;
  if(days!=null && days>0 && days<=365){
    
    months=(days/30).round() ;
     return 'for $months Month${months!=1?'s':''}';
  }else if(days!=null && days>0 && days>365){
    months=(days/30).round();
    years=(months/12).round();
    if(years!=0){
      months -=years*12;
    }
if(years>0 && months>0){
  return 'for $years Years${years!=1?'s':''} $months Month${months!=1?'s':''}';
}
     return 'for $years Years${years!=1?'s':''}';
  }
 return '';
}
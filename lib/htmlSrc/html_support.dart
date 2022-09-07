import 'dart:html';

void setHistoryLocation(int? location){
  window.history.go(location);
  window.location.replace('/login');
}
 
// web/category/links/category_links_web.dart 
 
import "dart:html"; 
 
import "package:ednet_core_default_app/ednet_core_default_app.dart"; 
import "package:category_links/category_links.dart"; 
 
initData(CoreRepository repository) { 
   var categoryDomain = repository.getDomainModels("Category"); 
   var linksModel = categoryDomain.getModelEntries("Links"); 
   linksModel.init(); 
   //linksModel.display(); 
} 
 
showData(CoreRepository repository) { 
   var mainView = new View(document, "main"); 
   mainView.repo = repository; 
   new RepoMainSection(mainView); 
} 
 
void main() { 
  var repository = new Repository(); 
  initData(repository); 
  showData(repository); 
} 
 

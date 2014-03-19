 
// web/category/links/category_links_web.dart 
 
import "dart:html"; 
 
import "package:dartling_default_app/dartling_default_app.dart"; 
import "package:category_links/category_links.dart"; 
 
initData(Repository repository) { 
   var categoryDomain = repository.getDomainModels("Category"); 
   var linksModel = categoryDomain.getModelEntries("Links"); 
   linksModel.init(); 
   //linksModel.display(); 
} 
 
showData(Repository repository) { 
   var mainView = new View(document, "main"); 
   mainView.repo = repository; 
   new RepoMainSection(mainView); 
} 
 
void main() { 
  var repository = new Repository(); 
  initData(repository); 
  showData(repository); 
} 
 

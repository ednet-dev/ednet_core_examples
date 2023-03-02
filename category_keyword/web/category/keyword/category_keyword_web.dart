 
// web/category/keyword/category_keyword_web.dart 
 
import "dart:html"; 
 
import "package:ednet_core_default_app/ednet_core_default_app.dart"; 
import "package:category_keyword/category_keyword.dart"; 
 
initData(CoreRepository repository) { 
   var categoryDomain = repository.getDomainModels("Category"); 
   var keywordModel = categoryDomain.getModelEntries("Keyword"); 
   keywordModel.init(); 
   //keywordModel.display(); 
} 
 
showData(CoreRepository repository) { 
   var mainView = new View(document, "main"); 
   mainView.repo = repository; 
   new RepoMainSection(mainView); 
} 
 
void main() { 
  var repository = CoreRepository(); 
  initData(repository); 
  showData(repository); 
} 
 

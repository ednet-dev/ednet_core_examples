 
// web/category/links/category_links_web.dart 
 

import "package:ednet_core/ednet_core.dart"; 
 
import "package:ednet_core_default_app/ednet_core_default_app.dart"; 
import "package:category_links/category_links.dart"; 
 
void initData(CoreRepository repository) { 
   CategoryDomain? categoryDomain = repository.getDomainModels("Category") as CategoryDomain?; 
   LinksModel? linksModel = categoryDomain?.getModelEntries("Links") as LinksModel?; 
   linksModel?.init(); 
   linksModel?.display(); 
} 
 
void showData(CoreRepository repository) { 
   // var mainView = View(document, "main"); 
   // mainView.repo = repository; 
   // new RepoMainSection(mainView); 
   print("not implemented"); 
} 
 
void main() { 
  var repository = CoreRepository(); 
  initData(repository); 
  showData(repository); 
} 
 

 
// test/category/links/category_links_gen.dart 
import "package:ednet_core/ednet_core.dart"; 
import "package:category_links/category_links.dart"; 
 
void genCode(CoreRepository repository) { 
  repository.gen("category_links"); 
} 
 
void initData(CoreRepository repository) { 
   var categoryDomain = repository.getDomainModels("Category"); 
   LinksModel? linksModel = categoryDomain?.getModelEntries("Links") as LinksModel?; 
   linksModel?.init(); 
   //linksModel.display(); 
} 
 
void main() { 
  var repository = CoreRepository(); 
  genCode(repository); 
  //initData(repository); 
} 
 

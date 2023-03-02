 
// test/category/links/category_links_gen.dart 
 
import "package:category_links/category_links.dart"; 
 
genCode(CoreRepository repository) { 
  repository.gen("category_links"); 
} 
 
initData(CoreRepository repository) { 
   var categoryDomain = repository.getDomainModels("Category"); 
   var linksModel = categoryDomain.getModelEntries("Links"); 
   linksModel.init(); 
   //linksModel.display(); 
} 
 
void main() { 
  var repository = CoreRepository(); 
  genCode(repository); 
  //initData(repository); 
} 
 

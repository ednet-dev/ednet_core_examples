 
// test/category/links/category_links_gen.dart 
 
import "package:category_links/category_links.dart"; 
 
genCode(Repository repository) { 
  repository.gen("category_links"); 
} 
 
initData(Repository repository) { 
   var categoryDomain = repository.getDomainModels("Category"); 
   var linksModel = categoryDomain.getModelEntries("Links"); 
   linksModel.init(); 
   //linksModel.display(); 
} 
 
void main() { 
  var repository = new Repository(); 
  genCode(repository); 
  //initData(repository); 
} 
 

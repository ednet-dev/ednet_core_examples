 
// test/category/keyword/category_keyword_gen.dart 
 
import "package:category_keyword/category_keyword.dart"; 
 
genCode(CoreRepository repository) { 
  repository.gen("category_keyword"); 
} 
 
initData(CoreRepository repository) { 
   var categoryDomain = repository.getDomainModels("Category"); 
   var keywordModel = categoryDomain.getModelEntries("Keyword"); 
   keywordModel.init(); 
   //keywordModel.display(); 
} 
 
void main() { 
  var repository = new Repository(); 
  genCode(repository); 
  //initData(repository); 
} 
 

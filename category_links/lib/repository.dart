part of category_links; 
 
// lib/repository.dart 
 
class Repository extends CoreRepository { 
 
  static const REPOSITORY = "Repository"; 
 
  Repository([String code=REPOSITORY]) : super(code) { 
    var domain = Domain("Category"); 
    domains.add(domain); 
    add(CategoryDomain(domain)); 
 
  } 
 
} 
 

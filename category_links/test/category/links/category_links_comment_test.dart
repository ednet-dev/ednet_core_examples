 
// test/category/links/category_links_comment_test.dart 
 
import "package:test/test.dart"; 
import "package:ednet_core/ednet_core.dart"; 
import "package:category_links/category_links.dart"; 
 
void testCategoryLinksComments( 
    CategoryDomain categoryDomain, LinksModel linksModel, Comments comments) { 
  DomainSession session; 
  group("Testing Category.Links.Comment", () { 
    session = categoryDomain.newSession();  
    setUp(() { 
      linksModel.init(); 
    }); 
    tearDown(() { 
      linksModel.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(linksModel.isEmpty, isFalse); 
      expect(comments.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      linksModel.clear(); 
      expect(linksModel.isEmpty, isTrue); 
      expect(comments.isEmpty, isTrue); 
      expect(comments.exceptions.isEmpty, isTrue); 
    }); 
 
    test("From model to JSON", () { 
      var json = linksModel.toJson(); 
      expect(json, isNotNull); 
 
      print(json); 
      //linksModel.displayJson(); 
      //linksModel.display(); 
    }); 
 
    test("From JSON to model", () { 
      var json = linksModel.toJson(); 
      linksModel.clear(); 
      expect(linksModel.isEmpty, isTrue); 
      linksModel.fromJson(json); 
      expect(linksModel.isEmpty, isFalse); 
 
      linksModel.display(); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = linksModel.fromEntryToJson("Comment"); 
      expect(json, isNotNull); 
 
      print(json); 
      //linksModel.displayEntryJson("Comment"); 
      //linksModel.displayJson(); 
      //linksModel.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = linksModel.fromEntryToJson("Comment"); 
      comments.clear(); 
      expect(comments.isEmpty, isTrue); 
      linksModel.fromJsonToEntry(json); 
      expect(comments.isEmpty, isFalse); 
 
      comments.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add comment required error", () { 
      var commentConcept = comments.concept; 
      var commentCount = comments.length; 
      var comment = Comment(commentConcept); 
      var added = comments.add(comment); 
      expect(added, isFalse); 
      expect(comments.length, equals(commentCount)); 
      expect(comments.exceptions.length, greaterThan(0)); 
      expect(comments.exceptions.toList()[0].category, equals("required")); 
 
      comments.exceptions.display(title: "Add comment required error"); 
    }); 
 
    test("Add comment unique error", () { 
      // no id attribute 
    }); 
 
    test("Not found comment by oid", () { 
      var ednetOid = Oid.ts(1345648254063); 
      var comment = comments.singleWhereOid(ednetOid); 
      expect(comment, isNull); 
    }); 
 
    test("Find comment by oid", () { 
      var randomComment = comments.random(); 
      var comment = comments.singleWhereOid(randomComment.oid); 
      expect(comment, isNotNull); 
      expect(comment, equals(randomComment)); 
    }); 
 
    test("Find comment by attribute id", () { 
      // no id attribute 
    }); 
 
    test("Find comment by required attribute", () { 
      var randomComment = comments.random(); 
      var comment = 
          comments.firstWhereAttribute("text", randomComment.text); 
      expect(comment, isNotNull); 
      expect(comment.text, equals(randomComment.text)); 
    }); 
 
    test("Find comment by attribute", () { 
      var randomComment = comments.random(); 
      var comment = 
          comments.firstWhereAttribute("source", randomComment.source); 
      expect(comment, isNotNull); 
      expect(comment.source, equals(randomComment.source)); 
    }); 
 
    test("Select comments by attribute", () { 
      var randomComment = comments.random(); 
      var selectedComments = 
          comments.selectWhereAttribute("source", randomComment.source); 
      expect(selectedComments.isEmpty, isFalse); 
      selectedComments.forEach((se) => 
          expect(se.source, equals(randomComment.source))); 
 
      //selectedComments.display(title: "Select comments by source"); 
    }); 
 
    test("Select comments by required attribute", () { 
      var randomComment = comments.random(); 
      var selectedComments = 
          comments.selectWhereAttribute("text", randomComment.text); 
      expect(selectedComments.isEmpty, isFalse); 
      selectedComments.forEach((se) => 
          expect(se.text, equals(randomComment.text))); 
 
      //selectedComments.display(title: "Select comments by text"); 
    }); 
 
    test("Select comments by attribute, then add", () { 
      var randomComment = comments.random(); 
      var selectedComments = 
          comments.selectWhereAttribute("text", randomComment.text); 
      expect(selectedComments.isEmpty, isFalse); 
      expect(selectedComments.source?.isEmpty, isFalse); 
      var commentsCount = comments.length; 
 
      var comment = Comment(comments.concept); 
      comment.text = 'distance'; 
      comment.source = 'yellow'; 
      comment.createdOn = new DateTime.now(); 
      var added = selectedComments.add(comment); 
      expect(added, isTrue); 
      expect(comments.length, equals(++commentsCount)); 
 
      //selectedComments.display(title: 
      //  "Select comments by attribute, then add"); 
      //comments.display(title: "All comments"); 
    }); 
 
    test("Select comments by attribute, then remove", () { 
      var randomComment = comments.random(); 
      var selectedComments = 
          comments.selectWhereAttribute("text", randomComment.text); 
      expect(selectedComments.isEmpty, isFalse); 
      expect(selectedComments.source?.isEmpty, isFalse); 
      var commentsCount = comments.length; 
 
      var removed = selectedComments.remove(randomComment); 
      expect(removed, isTrue); 
      expect(comments.length, equals(--commentsCount)); 
 
      randomComment.display(prefix: "removed"); 
      //selectedComments.display(title: 
      //  "Select comments by attribute, then remove"); 
      //comments.display(title: "All comments"); 
    }); 
 
    test("Sort comments", () { 
      // no id attribute 
      // add compareTo method in the specific Comment class 
      /* 
      comments.sort(); 
 
      //comments.display(title: "Sort comments"); 
      */ 
    }); 
 
    test("Order comments", () { 
      // no id attribute 
      // add compareTo method in the specific Comment class 
      /* 
      var orderedComments = comments.order(); 
      expect(orderedComments.isEmpty, isFalse); 
      expect(orderedComments.length, equals(comments.length)); 
      expect(orderedComments.source?.isEmpty, isFalse); 
      expect(orderedComments.source?.length, equals(comments.length)); 
      expect(orderedComments, isNot(same(comments))); 
 
      //orderedComments.display(title: "Order comments"); 
      */ 
    }); 
 
    test("Copy comments", () { 
      var copiedComments = comments.copy(); 
      expect(copiedComments.isEmpty, isFalse); 
      expect(copiedComments.length, equals(comments.length)); 
      expect(copiedComments, isNot(same(comments))); 
      copiedComments.forEach((e) => 
        expect(e, equals(comments.singleWhereOid(e.oid)))); 
 
      //copiedComments.display(title: "Copy comments"); 
    }); 
 
    test("True for every comment", () { 
      expect(comments.every((e) => e.text != null), isTrue); 
    }); 
 
    test("Random comment", () { 
      var comment1 = comments.random(); 
      expect(comment1, isNotNull); 
      var comment2 = comments.random(); 
      expect(comment2, isNotNull); 
 
      //comment1.display(prefix: "random1"); 
      //comment2.display(prefix: "random2"); 
    }); 
 
    test("Update comment id with try", () { 
      // no id attribute 
    }); 
 
    test("Update comment id without try", () { 
      // no id attribute 
    }); 
 
    test("Update comment id with success", () { 
      // no id attribute 
    }); 
 
    test("Update comment non id attribute with failure", () { 
      var randomComment = comments.random(); 
      var afterUpdateEntity = randomComment.copy(); 
      afterUpdateEntity.text = 'big'; 
      expect(afterUpdateEntity.text, equals('big')); 
      // comments.update can only be used if oid, code or id is set. 
      expect(() => comments.update(randomComment, afterUpdateEntity), throws); 
    }); 
 
    test("Copy Equality", () { 
      var randomComment = comments.random(); 
      randomComment.display(prefix:"before copy: "); 
      var randomCommentCopy = randomComment.copy(); 
      randomCommentCopy.display(prefix:"after copy: "); 
      expect(randomComment, equals(randomCommentCopy)); 
      expect(randomComment.oid, equals(randomCommentCopy.oid)); 
      expect(randomComment.code, equals(randomCommentCopy.code)); 
      expect(randomComment.text, equals(randomCommentCopy.text)); 
      expect(randomComment.source, equals(randomCommentCopy.source)); 
      expect(randomComment.createdOn, equals(randomCommentCopy.createdOn)); 
 
    }); 
 
    test("comment action undo and redo", () { 
      var commentCount = comments.length; 
      var comment = Comment(comments.concept); 
        comment.text = 'hospital'; 
      comment.source = 'hat'; 
      comment.createdOn = new DateTime.now(); 
      comments.add(comment); 
      expect(comments.length, equals(++commentCount)); 
      comments.remove(comment); 
      expect(comments.length, equals(--commentCount)); 
 
      var action = AddCommand(session, comments, comment); 
      action.doIt(); 
      expect(comments.length, equals(++commentCount)); 
 
      action.undo(); 
      expect(comments.length, equals(--commentCount)); 
 
      action.redo(); 
      expect(comments.length, equals(++commentCount)); 
    }); 
 
    test("comment session undo and redo", () { 
      var commentCount = comments.length; 
      var comment = Comment(comments.concept); 
        comment.text = 'cable'; 
      comment.source = 'service'; 
      comment.createdOn = new DateTime.now(); 
      comments.add(comment); 
      expect(comments.length, equals(++commentCount)); 
      comments.remove(comment); 
      expect(comments.length, equals(--commentCount)); 
 
      var action = AddCommand(session, comments, comment); 
      action.doIt(); 
      expect(comments.length, equals(++commentCount)); 
 
      session.past.undo(); 
      expect(comments.length, equals(--commentCount)); 
 
      session.past.redo(); 
      expect(comments.length, equals(++commentCount)); 
    }); 
 
    test("Comment update undo and redo", () { 
      var comment = comments.random(); 
      var action = SetAttributeCommand(session, comment, "text", 'call'); 
      action.doIt(); 
 
      session.past.undo(); 
      expect(comment.text, equals(action.before)); 
 
      session.past.redo(); 
      expect(comment.text, equals(action.after)); 
    }); 
 
    test("Comment action with multiple undos and redos", () { 
      var commentCount = comments.length; 
      var comment1 = comments.random(); 
 
      var action1 = RemoveCommand(session, comments, comment1); 
      action1.doIt(); 
      expect(comments.length, equals(--commentCount)); 
 
      var comment2 = comments.random(); 
 
      var action2 = RemoveCommand(session, comments, comment2); 
      action2.doIt(); 
      expect(comments.length, equals(--commentCount)); 
 
      //session.past.display(); 
 
      session.past.undo(); 
      expect(comments.length, equals(++commentCount)); 
 
      session.past.undo(); 
      expect(comments.length, equals(++commentCount)); 
 
      //session.past.display(); 
 
      session.past.redo(); 
      expect(comments.length, equals(--commentCount)); 
 
      session.past.redo(); 
      expect(comments.length, equals(--commentCount)); 
 
      //session.past.display(); 
    }); 
 
    test("Transaction undo and redo", () { 
      var commentCount = comments.length; 
      var comment1 = comments.random(); 
      var comment2 = comments.random(); 
      while (comment1 == comment2) { 
        comment2 = comments.random();  
      } 
      var action1 = RemoveCommand(session, comments, comment1); 
      var action2 = RemoveCommand(session, comments, comment2); 
 
      var transaction = new Transaction("two removes on comments", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      transaction.doIt(); 
      commentCount = commentCount - 2; 
      expect(comments.length, equals(commentCount)); 
 
      comments.display(title:"Transaction Done"); 
 
      session.past.undo(); 
      commentCount = commentCount + 2; 
      expect(comments.length, equals(commentCount)); 
 
      comments.display(title:"Transaction Undone"); 
 
      session.past.redo(); 
      commentCount = commentCount - 2; 
      expect(comments.length, equals(commentCount)); 
 
      comments.display(title:"Transaction Redone"); 
    }); 
 
    test("Transaction with one action error", () { 
      var commentCount = comments.length; 
      var comment1 = comments.random(); 
      var comment2 = comment1; 
      var action1 = RemoveCommand(session, comments, comment1); 
      var action2 = RemoveCommand(session, comments, comment2); 
 
      var transaction = Transaction( 
        "two removes on comments, with an error on the second", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      var done = transaction.doIt(); 
      expect(done, isFalse); 
      expect(comments.length, equals(commentCount)); 
 
      //comments.display(title:"Transaction with an error"); 
    }); 
 
    test("Reactions to comment actions", () { 
      var commentCount = comments.length; 
 
      var reaction = CommentReaction(); 
      expect(reaction, isNotNull); 
 
      categoryDomain.startCommandReaction(reaction); 
      var comment = Comment(comments.concept); 
        comment.text = 'car'; 
      comment.source = 'sin'; 
      comment.createdOn = new DateTime.now(); 
      comments.add(comment); 
      expect(comments.length, equals(++commentCount)); 
      comments.remove(comment); 
      expect(comments.length, equals(--commentCount)); 
 
      var session = categoryDomain.newSession(); 
      var addCommand = AddCommand(session, comments, comment); 
      addCommand.doIt(); 
      expect(comments.length, equals(++commentCount)); 
      expect(reaction.reactedOnAdd, isTrue); 
 
      var setAttributeCommand = SetAttributeCommand( 
        session, comment, "text", 'discount'); 
      setAttributeCommand.doIt(); 
      expect(reaction.reactedOnUpdate, isTrue); 
      categoryDomain.cancelCommandReaction(reaction); 
    }); 
 
  }); 
} 
 
class CommentReaction implements ICommandReaction { 
  bool reactedOnAdd    = false; 
  bool reactedOnUpdate = false; 
 
  void react(ICommand action) { 
    if (action is IEntitiesCommand) { 
      reactedOnAdd = true; 
    } else if (action is IEntityCommand) { 
      reactedOnUpdate = true; 
    } 
  } 
} 
 
void main() { 
  var repository = Repository(); 
  CategoryDomain categoryDomain = repository.getDomainModels("Category") as CategoryDomain;   
  assert(categoryDomain != null); 
  LinksModel linksModel = categoryDomain.getModelEntries("Links") as LinksModel;  
  assert(linksModel != null); 
  var comments = linksModel.comments; 
  testCategoryLinksComments(categoryDomain, linksModel, comments); 
} 
 

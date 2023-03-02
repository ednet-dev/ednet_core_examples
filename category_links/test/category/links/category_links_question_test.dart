 
// test/category/links/category_links_question_test.dart 
 
import "package:test/test.dart"; 
import "package:ednet_core/ednet_core.dart"; 
import "package:category_links/category_links.dart"; 
 
void testCategoryLinksQuestions( 
    CategoryDomain categoryDomain, LinksModel linksModel, Questions questions) { 
  DomainSession session; 
  group("Testing Category.Links.Question", () { 
    session = categoryDomain.newSession();  
    setUp(() { 
      linksModel.init(); 
    }); 
    tearDown(() { 
      linksModel.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(linksModel.isEmpty, isFalse); 
      expect(questions.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      linksModel.clear(); 
      expect(linksModel.isEmpty, isTrue); 
      expect(questions.isEmpty, isTrue); 
      expect(questions.exceptions.isEmpty, isTrue); 
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
      var json = linksModel.fromEntryToJson("Question"); 
      expect(json, isNotNull); 
 
      print(json); 
      //linksModel.displayEntryJson("Question"); 
      //linksModel.displayJson(); 
      //linksModel.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = linksModel.fromEntryToJson("Question"); 
      questions.clear(); 
      expect(questions.isEmpty, isTrue); 
      linksModel.fromJsonToEntry(json); 
      expect(questions.isEmpty, isFalse); 
 
      questions.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add question required error", () { 
      var questionConcept = questions.concept; 
      var questionCount = questions.length; 
      var question = Question(questionConcept); 
      var added = questions.add(question); 
      expect(added, isFalse); 
      expect(questions.length, equals(questionCount)); 
      expect(questions.exceptions.length, greaterThan(0)); 
      expect(questions.exceptions.toList()[0].category, equals("required")); 
 
      questions.exceptions.display(title: "Add question required error"); 
    }); 
 
    test("Add question unique error", () { 
      // id attribute defined as increment, cannot update it 
    }); 
 
    test("Not found question by oid", () { 
      var ednetOid = Oid.ts(1345648254063); 
      var question = questions.singleWhereOid(ednetOid); 
      expect(question, isNull); 
    }); 
 
    test("Find question by oid", () { 
      var randomQuestion = questions.random(); 
      var question = questions.singleWhereOid(randomQuestion.oid); 
      expect(question, isNotNull); 
      expect(question, equals(randomQuestion)); 
    }); 
 
    test("Find question by attribute id", () { 
      var randomQuestion = questions.random(); 
      var question = 
          questions.singleWhereAttributeId("number", randomQuestion.number); 
      expect(question, isNotNull); 
      expect(question!.number, equals(randomQuestion.number)); 
    }); 
 
    test("Find question by required attribute", () { 
      var randomQuestion = questions.random(); 
      var question = 
          questions.firstWhereAttribute("text", randomQuestion.text); 
      expect(question, isNotNull); 
      expect(question.text, equals(randomQuestion.text)); 
    }); 
 
    test("Find question by attribute", () { 
      var randomQuestion = questions.random(); 
      var question = 
          questions.firstWhereAttribute("type", randomQuestion.type); 
      expect(question, isNotNull); 
      expect(question.type, equals(randomQuestion.type)); 
    }); 
 
    test("Select questions by attribute", () { 
      var randomQuestion = questions.random(); 
      var selectedQuestions = 
          questions.selectWhereAttribute("type", randomQuestion.type); 
      expect(selectedQuestions.isEmpty, isFalse); 
      selectedQuestions.forEach((se) => 
          expect(se.type, equals(randomQuestion.type))); 
 
      //selectedQuestions.display(title: "Select questions by type"); 
    }); 
 
    test("Select questions by required attribute", () { 
      var randomQuestion = questions.random(); 
      var selectedQuestions = 
          questions.selectWhereAttribute("text", randomQuestion.text); 
      expect(selectedQuestions.isEmpty, isFalse); 
      selectedQuestions.forEach((se) => 
          expect(se.text, equals(randomQuestion.text))); 
 
      //selectedQuestions.display(title: "Select questions by text"); 
    }); 
 
    test("Select questions by attribute, then add", () { 
      var randomQuestion = questions.random(); 
      var selectedQuestions = 
          questions.selectWhereAttribute("type", randomQuestion.type); 
      expect(selectedQuestions.isEmpty, isFalse); 
      expect(selectedQuestions.source?.isEmpty, isFalse); 
      var questionsCount = questions.length; 
 
      var question = Question(questions.concept); 
      question.type = 'test'; 
      question.text = 'sin'; 
      question.response = 'down'; 
      question.createdOn = 'notch'; 
      question.points = 818; 
      var added = selectedQuestions.add(question); 
      expect(added, isTrue); 
      expect(questions.length, equals(++questionsCount)); 
 
      //selectedQuestions.display(title: 
      //  "Select questions by attribute, then add"); 
      //questions.display(title: "All questions"); 
    }); 
 
    test("Select questions by attribute, then remove", () { 
      var randomQuestion = questions.random(); 
      var selectedQuestions = 
          questions.selectWhereAttribute("type", randomQuestion.type); 
      expect(selectedQuestions.isEmpty, isFalse); 
      expect(selectedQuestions.source?.isEmpty, isFalse); 
      var questionsCount = questions.length; 
 
      var removed = selectedQuestions.remove(randomQuestion); 
      expect(removed, isTrue); 
      expect(questions.length, equals(--questionsCount)); 
 
      randomQuestion.display(prefix: "removed"); 
      //selectedQuestions.display(title: 
      //  "Select questions by attribute, then remove"); 
      //questions.display(title: "All questions"); 
    }); 
 
    test("Sort questions", () { 
      questions.sort(); 
 
      //questions.display(title: "Sort questions"); 
    }); 
 
    test("Order questions", () { 
      var orderedQuestions = questions.order(); 
      expect(orderedQuestions.isEmpty, isFalse); 
      expect(orderedQuestions.length, equals(questions.length)); 
      expect(orderedQuestions.source?.isEmpty, isFalse); 
      expect(orderedQuestions.source?.length, equals(questions.length)); 
      expect(orderedQuestions, isNot(same(questions))); 
 
      //orderedQuestions.display(title: "Order questions"); 
    }); 
 
    test("Copy questions", () { 
      var copiedQuestions = questions.copy(); 
      expect(copiedQuestions.isEmpty, isFalse); 
      expect(copiedQuestions.length, equals(questions.length)); 
      expect(copiedQuestions, isNot(same(questions))); 
      copiedQuestions.forEach((e) => 
        expect(e, equals(questions.singleWhereOid(e.oid)))); 
      copiedQuestions.forEach((e) => 
        expect(e, isNot(same(questions.singleWhereId(e.id!))))); 
 
      //copiedQuestions.display(title: "Copy questions"); 
    }); 
 
    test("True for every question", () { 
      expect(questions.every((e) => e.text != null), isTrue); 
    }); 
 
    test("Random question", () { 
      var question1 = questions.random(); 
      expect(question1, isNotNull); 
      var question2 = questions.random(); 
      expect(question2, isNotNull); 
 
      //question1.display(prefix: "random1"); 
      //question2.display(prefix: "random2"); 
    }); 
 
    test("Update question id with try", () { 
      // id attribute defined as increment, cannot update it 
    }); 
 
    test("Update question id without try", () { 
      // id attribute defined as increment, cannot update it 
    }); 
 
    test("Update question id with success", () { 
      // id attribute defined as increment, cannot update it 
    }); 
 
    test("Update question non id attribute with failure", () { 
      var randomQuestion = questions.random(); 
      var afterUpdateEntity = randomQuestion.copy(); 
      afterUpdateEntity.type = 'electronic'; 
      expect(afterUpdateEntity.type, equals('electronic')); 
      // questions.update can only be used if oid, code or id is set. 
      expect(() => questions.update(randomQuestion, afterUpdateEntity), throws); 
    }); 
 
    test("Copy Equality", () { 
      var randomQuestion = questions.random(); 
      randomQuestion.display(prefix:"before copy: "); 
      var randomQuestionCopy = randomQuestion.copy(); 
      randomQuestionCopy.display(prefix:"after copy: "); 
      expect(randomQuestion, equals(randomQuestionCopy)); 
      expect(randomQuestion.oid, equals(randomQuestionCopy.oid)); 
      expect(randomQuestion.code, equals(randomQuestionCopy.code)); 
      expect(randomQuestion.number, equals(randomQuestionCopy.number)); 
      expect(randomQuestion.type, equals(randomQuestionCopy.type)); 
      expect(randomQuestion.text, equals(randomQuestionCopy.text)); 
      expect(randomQuestion.response, equals(randomQuestionCopy.response)); 
      expect(randomQuestion.createdOn, equals(randomQuestionCopy.createdOn)); 
      expect(randomQuestion.points, equals(randomQuestionCopy.points)); 
 
      expect(randomQuestion.id, isNotNull); 
      expect(randomQuestionCopy.id, isNotNull); 
      expect(randomQuestion.id, equals(randomQuestionCopy.id)); 
 
      var idsEqual = false; 
      if (randomQuestion.id == randomQuestionCopy.id) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
 
      idsEqual = false; 
      if (randomQuestion.id!.equals(randomQuestionCopy.id!)) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
    }); 
 
    test("question action undo and redo", () { 
      var questionCount = questions.length; 
      var question = Question(questions.concept); 
        question.type = 'team'; 
      question.text = 'train'; 
      question.response = 'television'; 
      question.createdOn = 'holiday'; 
      question.points = -169.19487807843646; 
      questions.add(question); 
      expect(questions.length, equals(++questionCount)); 
      questions.remove(question); 
      expect(questions.length, equals(--questionCount)); 
 
      var action = AddCommand(session, questions, question); 
      action.doIt(); 
      expect(questions.length, equals(++questionCount)); 
 
      action.undo(); 
      expect(questions.length, equals(--questionCount)); 
 
      action.redo(); 
      expect(questions.length, equals(++questionCount)); 
    }); 
 
    test("question session undo and redo", () { 
      var questionCount = questions.length; 
      var question = Question(questions.concept); 
        question.type = 'beach'; 
      question.text = 'blue'; 
      question.response = 'meter'; 
      question.createdOn = 'small'; 
      question.points = 880.1147923867616; 
      questions.add(question); 
      expect(questions.length, equals(++questionCount)); 
      questions.remove(question); 
      expect(questions.length, equals(--questionCount)); 
 
      var action = AddCommand(session, questions, question); 
      action.doIt(); 
      expect(questions.length, equals(++questionCount)); 
 
      session.past.undo(); 
      expect(questions.length, equals(--questionCount)); 
 
      session.past.redo(); 
      expect(questions.length, equals(++questionCount)); 
    }); 
 
    test("Question update undo and redo", () { 
      var question = questions.random(); 
      var action = SetAttributeCommand(session, question, "type", 'taxi'); 
      action.doIt(); 
 
      session.past.undo(); 
      expect(question.type, equals(action.before)); 
 
      session.past.redo(); 
      expect(question.type, equals(action.after)); 
    }); 
 
    test("Question action with multiple undos and redos", () { 
      var questionCount = questions.length; 
      var question1 = questions.random(); 
 
      var action1 = RemoveCommand(session, questions, question1); 
      action1.doIt(); 
      expect(questions.length, equals(--questionCount)); 
 
      var question2 = questions.random(); 
 
      var action2 = RemoveCommand(session, questions, question2); 
      action2.doIt(); 
      expect(questions.length, equals(--questionCount)); 
 
      //session.past.display(); 
 
      session.past.undo(); 
      expect(questions.length, equals(++questionCount)); 
 
      session.past.undo(); 
      expect(questions.length, equals(++questionCount)); 
 
      //session.past.display(); 
 
      session.past.redo(); 
      expect(questions.length, equals(--questionCount)); 
 
      session.past.redo(); 
      expect(questions.length, equals(--questionCount)); 
 
      //session.past.display(); 
    }); 
 
    test("Transaction undo and redo", () { 
      var questionCount = questions.length; 
      var question1 = questions.random(); 
      var question2 = questions.random(); 
      while (question1 == question2) { 
        question2 = questions.random();  
      } 
      var action1 = RemoveCommand(session, questions, question1); 
      var action2 = RemoveCommand(session, questions, question2); 
 
      var transaction = new Transaction("two removes on questions", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      transaction.doIt(); 
      questionCount = questionCount - 2; 
      expect(questions.length, equals(questionCount)); 
 
      questions.display(title:"Transaction Done"); 
 
      session.past.undo(); 
      questionCount = questionCount + 2; 
      expect(questions.length, equals(questionCount)); 
 
      questions.display(title:"Transaction Undone"); 
 
      session.past.redo(); 
      questionCount = questionCount - 2; 
      expect(questions.length, equals(questionCount)); 
 
      questions.display(title:"Transaction Redone"); 
    }); 
 
    test("Transaction with one action error", () { 
      var questionCount = questions.length; 
      var question1 = questions.random(); 
      var question2 = question1; 
      var action1 = RemoveCommand(session, questions, question1); 
      var action2 = RemoveCommand(session, questions, question2); 
 
      var transaction = Transaction( 
        "two removes on questions, with an error on the second", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      var done = transaction.doIt(); 
      expect(done, isFalse); 
      expect(questions.length, equals(questionCount)); 
 
      //questions.display(title:"Transaction with an error"); 
    }); 
 
    test("Reactions to question actions", () { 
      var questionCount = questions.length; 
 
      var reaction = QuestionReaction(); 
      expect(reaction, isNotNull); 
 
      categoryDomain.startCommandReaction(reaction); 
      var question = Question(questions.concept); 
        question.type = 'advisor'; 
      question.text = 'cash'; 
      question.response = 'beginning'; 
      question.createdOn = 'wife'; 
      question.points = 251; 
      questions.add(question); 
      expect(questions.length, equals(++questionCount)); 
      questions.remove(question); 
      expect(questions.length, equals(--questionCount)); 
 
      var session = categoryDomain.newSession(); 
      var addCommand = AddCommand(session, questions, question); 
      addCommand.doIt(); 
      expect(questions.length, equals(++questionCount)); 
      expect(reaction.reactedOnAdd, isTrue); 
 
      var setAttributeCommand = SetAttributeCommand( 
        session, question, "type", 'call'); 
      setAttributeCommand.doIt(); 
      expect(reaction.reactedOnUpdate, isTrue); 
      categoryDomain.cancelCommandReaction(reaction); 
    }); 
 
  }); 
} 
 
class QuestionReaction implements ICommandReaction { 
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
  var questions = linksModel.questions; 
  testCategoryLinksQuestions(categoryDomain, linksModel, questions); 
} 
 

Class {
	#name : #SmallLintWarningImporter,
	#superclass : #Object,
	#instVars : [
		'dico',
		'model'
	],
	#category : #'SmallLintMaps-Famix'
}

{ #category : #'as yet unclassified' }
SmallLintWarningImporter >> createFamixSmallLintRule: aRule [ 

     ^ FAMIXSmallLintRule new 
		name: aRule class name;
		description: aRule name;
		rationale: aRule rationale.
]

{ #category : #'as yet unclassified' }
SmallLintWarningImporter >> findFamixMethod: cpMethod [ 
	
	| mName mClass |
	cpMethod isCompiledMethod  ifFalse: [^ nil].
	
	mName := cpMethod selector.
	mClass := cpMethod methodClass name.
	
	^ model allModelMethods detect: [ :each | (each name = mName) and: [ each belongsTo name = mClass ]] ifNone: [ ^ nil ]
]

{ #category : #'as yet unclassified' }
SmallLintWarningImporter >> findFamixMethods: cpMethods [
	
	^ cpMethods collect: [ :cpMthd |   self findFamixMethod: cpMthd  ]
]

{ #category : #'as yet unclassified' }
SmallLintWarningImporter >> importWarningOn: aPackage [
	dico := CheckSmallLintMaps new runOn: aPackage;  buildDico ; dico.
]

{ #category : #accessing }
SmallLintWarningImporter >> model [
	^ model
]

{ #category : #accessing }
SmallLintWarningImporter >> model: anObject [
	model := anObject
]

{ #category : #accessing }
SmallLintWarningImporter >> updateModel [
	dico keys do: [ :rule | 		
		| famixRule famixMethods|				
		famixRule := self createFamixSmallLintRule: rule new.
		model add: famixRule.		
		famixMethods := self findFamixMethods: ((dico at: rule) asOrderedCollection flatCollect:  #yourself).		
		famixMethods := famixMethods reject: #isNil.		
		famixMethods ifNotEmpty:  [
			famixRule methods: famixMethods	 ]].
			
]

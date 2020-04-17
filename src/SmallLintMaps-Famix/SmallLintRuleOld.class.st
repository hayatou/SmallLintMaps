Class {
	#name : #SmallLintRuleOld,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'SmallLintMaps-Famix'
}

{ #category : #'as yet unclassified' }
SmallLintRuleOld class >> import [
self initialize.
RBBlockLintRule subclassesDo: [:r | model add: (FAMIXSmallLintRule new name: (r name) ; yourself) ].
MooseModel resetMeta.
]

{ #category : #'as yet unclassified' }
SmallLintRuleOld class >> initialize [
"model := MooseModel root allModels first."
]

{ #category : #'as yet unclassified' }
SmallLintRuleOld >> allRules [
model := MooseModel root allModels first.
(RBCompositeLintRule  allGoodRules rules flatCollect: #leaves) subclassesDo: [:r | model add: (FAMIXSmallLintRule new name: (r name) ; yourself) ].

]

{ #category : #'as yet unclassified' }
SmallLintRuleOld >> createRule: aRBLintRule [ 
 	|aRule|
	aRule := FAMIXSmallLintRule new 
		name: aRBLintRule name; yourself.
		"rationale: aRBLintRule rationale;"
	^ aRule.

]

{ #category : #'as yet unclassified' }
SmallLintRuleOld >> getName: aRBLintRule [ 
 	|aWarning|
	aWarning := FAMIXSmallLintRule new name: aRBLintRule name; yourself.
	^ aWarning.

]

{ #category : #'as yet unclassified' }
SmallLintRuleOld >> model [
	^ model
]

{ #category : #'as yet unclassified' }
SmallLintRuleOld >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
SmallLintRuleOld >> name: aRBLintRule [ 
 	|aRule|
	aRule := FAMIXSmallLintRule new 
		name: aRBLintRule name; yourself.
		"rationale: aRBLintRule rationale;"
	^ aRule.

]

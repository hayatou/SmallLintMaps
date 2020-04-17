Class {
	#name : #CheckSmallLintMaps,
	#superclass : #Object,
	#instVars : [
		'env',
		'rules',
		'checker',
		'dicoEnv',
		'dicoClass',
		'dicoMethod',
		'dico'
	],
	#category : #'SmallLintMaps-Core'
}

{ #category : #'as yet unclassified' }
CheckSmallLintMaps class >> demo [

	"self demo"

	|  d|
	"test:="^ (CheckSmallLintMaps  new  runOn: 'Famix-Core' ) buildDico.
	
	"test runOn: 'Famix-Core'.
	test buildDico.
	"
	"d:=ROMSmallLintMaps new.
	d dico: test dicoMethod.
	d createSmallLintMapsView: 'Famix-Core' ; openView ."
]

{ #category : #'as yet unclassified' }
CheckSmallLintMaps class >> demoOn: aPackage [
	^ (CheckSmallLintMaps  new  runOn: aPackage ) buildDico.
	
	
]

{ #category : #'as yet unclassified' }
CheckSmallLintMaps >> buildDico [

rules leaves do: [ :rl | 
	rl critics do: [:critic | |temp|
		temp := critic isCompiledMethod 
			ifTrue: [ (critic  methodClass  theNonMetaClass name)] 
			ifFalse: [ critic name. ].
		(dico at: (rl class)) at: temp ifPresent: [:col | 
			col add: critic. ] ]] .



]

{ #category : #'as yet unclassified' }
CheckSmallLintMaps >> buildDicoClass [


	(rules leaves gather: [:rule | rule critics])
		do: [:critic | | cl |
			cl := (critic isCompiledMethod 
				ifTrue: [critic  methodClass] 
				ifFalse: [critic])  theNonMetaClass.
				dicoClass at: cl ifPresent: [(dicoClass at: cl) add: critic]].



]

{ #category : #'as yet unclassified' }
CheckSmallLintMaps >> buildDicoPackage [


	(rules leaves gather: [:rule | rule critics])
		do: [:critic | | cl |
			cl := (critic isCompiledMethod 
				ifTrue: [critic  methodClass] 
				ifFalse: [critic]).
			dicoEnv at:  ((self packageOfClass: cl) name) ifPresent: [(dicoEnv at: (self packageOfClass: cl) name) add: critic]]


]

{ #category : #accessing }
CheckSmallLintMaps >> checker [
	^ checker
]

{ #category : #private }
CheckSmallLintMaps >> createDicosOn: aMooseModel [
rules := RBCompositeLintRule allGoodRules.
rules resetResult.
dico:=Dictionary new.
rules leaves do:  [:rl | 
	dico at: rl  put: Dictionary new]. 
dico values do: [:d | 
	(MooseModel root allModels first allModelClasses)  do: [:cl|
		 d at: (cl   name) put:  OrderedCollection new] ].



]

{ #category : #accessing }
CheckSmallLintMaps >> dico [
	^ dico
]

{ #category : #accessing }
CheckSmallLintMaps >> dicoClass [
	^ dicoClass
]

{ #category : #accessing }
CheckSmallLintMaps >> dicoEnv [
	^ dicoEnv
]

{ #category : #accessing }
CheckSmallLintMaps >> dicoMethod [
	^ dicoMethod
]

{ #category : #accessing }
CheckSmallLintMaps >> env [
	^ env
]

{ #category : #'initialize-release' }
CheckSmallLintMaps >> initialize [ 

	env := RBPackageEnvironment new.
	rules := RBCompositeLintRule allGoodRules.
	checker := SmalllintManifestChecker new.
	dicoEnv := Dictionary new.
	dicoClass := Dictionary new.
	dicoMethod := Dictionary new.
	
	
	
	
	
]

{ #category : #'as yet unclassified' }
CheckSmallLintMaps >> packageOfClass: aClass [ 
	 MCWorkingCopy managersForClass: aClass do: [:package | ^ package ]
]

{ #category : #accessing }
CheckSmallLintMaps >> rules [
	^ rules
]

{ #category : #accessing }
CheckSmallLintMaps >> rules: anObject [
	rules := anObject
]

{ #category : #running }
CheckSmallLintMaps >> run [

	rules resetResult.

	env packages do: [:package |			
		package packageSet packages do: [:RPa |
		checker runRules: rules onPackage: RPa withoutTestCase: true] ].

]

{ #category : #running }
CheckSmallLintMaps >> runOn: aPackage [	
|allClasses|
allClasses:= MooseModel root allModels first allModelClasses.
env := RBPackageEnvironment new  packages: (MCWorkingCopy  allManagers  asOrderedCollection select: [ :e | e package name = aPackage  ]) . 
rules := RBCompositeLintRule allGoodRules.
rules resetResult.
checker := SmalllintManifestChecker new.
env packages do: [:package |
    package packageSet packages do: [:RPa |
          checker runRules: rules onPackage: RPa withoutTestCase: false.] ].



dico:=Dictionary new.
rules leaves do:  [:rl | 
	dico at: (rl class)  put: Dictionary new]. 
dico values do: [:d | 
	allClasses   do: [:cl|
		 d at: (cl   name) put:  OrderedCollection new.] ].


]

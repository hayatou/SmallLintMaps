Class {
	#name : #SMallLintMapBrowser,
	#superclass : #Object,
	#instVars : [
		'distributionMap'
	],
	#category : #'SmallLintMaps-Core'
}

{ #category : #example }
SMallLintMapBrowser class >> example1 [

	"self example1"
	|model distributionMap |
	model := MooseModel root allModels anyOne.
	distributionMap := DistributionMap onContainers: model allClasses elements: #methods  properties: #numberOfLinesOfCode.
	self openOn: distributionMap.
]

{ #category : #'instance creation' }
SMallLintMapBrowser class >> openOn: aDistributionMap [

	^ super new openOn: aDistributionMap
]

{ #category : #private }
SMallLintMapBrowser >> browser [

	|browser|
	browser := GLMTabulator new.
	browser title: 'Distribution Map'.
	
	browser row: #distributionMap.
	browser row: #sourceCode.
	
	browser transmit to: #distributionMap; andShow: [:a |
		a custom: self distributionMapPresentation.
		].
	browser transmit from: #distributionMap; to: #sourceCode ; andShow: [:a |
		a custom: self sourceCodePresentation. 
		]. 
	
	^ browser.
	
]

{ #category : #accessing }
SMallLintMapBrowser >> distributionMap [

	^ distributionMap
]

{ #category : #accessing }
SMallLintMapBrowser >> distributionMap: aDistributionMap [

	distributionMap := aDistributionMap
]

{ #category : #private }
SMallLintMapBrowser >> distributionMapPresentation [

	^ GLMMondrianPresentation new
		title: 'Distribution Map';
		painting: [:view :input |	
			input	renderOn: view.
			];
		when: [:input | input isKindOf: DistributionMap]
]

{ #category : #accessing }
SMallLintMapBrowser >> openOn: aDistributionMap [

	self distributionMap: aDistributionMap. 
	self browser openOn: self distributionMap.
]

{ #category : #private }
SMallLintMapBrowser >> sourceCodePresentation [

	^ GLMTextPresentation new
		forSmalltalk: [:input | Smalltalk at: input parentType name];
		display: [:input | input sourceText];
		when: [:input | input isKindOf: FAMIXMethod] 
]

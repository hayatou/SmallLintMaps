Class {
	#name : #ROMSmallLintMaps,
	#superclass : #Object,
	#instVars : [
		'view',
		'classes',
		'dico'
	],
	#category : #'SmallLintMaps-Core'
}

{ #category : #private }
ROMSmallLintMaps >> createClassView [
view shape rectangle withoutBorder.
view nodes: classes  forEach: [ :aClass |
	view shape label.
	view node: aClass.
	self createMethodView: aClass.
	view verticalLineLayout].
view gridLayout.

]

{ #category : #private }
ROMSmallLintMaps >> createMethodView: aClass [ 
	view node: aClass  forIt: [
			view shape rectangle size: 12;
			if: [ :c | (self sizeOf: c) =0 ] fillColor: Color green; 
			if: [ :c | (self sizeOf: c) >= 1 and:  [(self sizeOf: c) < 3] ] fillColor: Color orange;
			if: [ :c | (self sizeOf: c) >= 3 ] fillColor: Color red.
			view nodes: (aClass methods  sortedAs: [:c | (self sizeOf: c) ]).			
			view gridLayout gapSize: 2 ].
]

{ #category : #'as yet unclassified' }
ROMSmallLintMaps >> createSmallLintMapsView: aPackage [
classes:=Smalltalk allClasses select: [ :e | e category  =  aPackage  ].
self createClassView.
]

{ #category : #accessing }
ROMSmallLintMaps >> dico: aDictionary [ 
	dico := aDictionary.
]

{ #category : #'initialize-release' }
ROMSmallLintMaps >> initialize [ 
"super initialize."
view := ROMondrianViewBuilder new.

]

{ #category : #'as yet unclassified' }
ROMSmallLintMaps >> openView [
view gridLayout.
view open.
]

{ #category : #private }
ROMSmallLintMaps >> sizeOf: aMethod [ 
	|class mth res|
	class:=aMethod methodClass name.
	mth:= aMethod selector.
	res:=OrderedCollection new.
	
dico keysDo: [ :key  | (dico at: key) keysAndValuesDo: [:k :v | k=class ifTrue: [
								res addAll: ((dico at: key) at: k)  ]]].
				^	(res select: [ :each | each = aMethod  ]) size. 
				
						

]

{ #category : #accessing }
ROMSmallLintMaps >> view [
^ view.
]

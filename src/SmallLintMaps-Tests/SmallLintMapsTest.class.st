Class {
	#name : #SmallLintMapsTest,
	#superclass : #TestCase,
	#category : #'SmallLintMaps-Tests'
}

{ #category : #'as yet unclassified' }
SmallLintMapsTest >> testInitialize [
|aSmallLintMaps|
aSmallLintMaps:= ROMSmallLintMaps new.
self assert: ROMondrianViewBuilder equals: (aSmallLintMaps view class) .
]

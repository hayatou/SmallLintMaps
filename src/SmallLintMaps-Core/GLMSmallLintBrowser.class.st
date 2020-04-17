Class {
	#name : #GLMSmallLintBrowser,
	#superclass : #GLMBrowser,
	#instVars : [
		'browser'
	],
	#category : #'SmallLintMaps-Core'
}

{ #category : #'as yet unclassified' }
GLMSmallLintBrowser >> initialize [ 
browser := GLMFinder new.

]

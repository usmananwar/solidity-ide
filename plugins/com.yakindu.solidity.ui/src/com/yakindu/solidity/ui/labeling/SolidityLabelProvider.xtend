/*
 * generated by Xtext 2.12.0
 */
package com.yakindu.solidity.ui.labeling

import com.google.inject.Inject
import com.yakindu.solidity.solidity.ArrayTypeSpecifier
import com.yakindu.solidity.solidity.BuildInModifier
import com.yakindu.solidity.solidity.ContractDefinition
import com.yakindu.solidity.solidity.EventDefinition
import com.yakindu.solidity.solidity.FunctionDefinition
import com.yakindu.solidity.solidity.FunctionModifier
import com.yakindu.solidity.solidity.IndexParameter
import com.yakindu.solidity.solidity.MappingTypeSpecifier
import com.yakindu.solidity.solidity.Modifier
import com.yakindu.solidity.solidity.Parameter
import com.yakindu.solidity.solidity.VariableDefinition
import com.yakindu.solidity.solidity.Visibility
import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider
import org.eclipse.xtext.ui.label.DefaultEObjectLabelProvider
import org.yakindu.base.types.Package
import org.yakindu.base.types.Type
import org.yakindu.base.types.TypeSpecifier

/**
 * Provides labels for EObjects.
 * 
 * See https://www.eclipse.org/Xtext/documentation/304_ide_concepts.html#label-provider
 */
class SolidityLabelProvider extends DefaultEObjectLabelProvider {

	@Inject
	new(AdapterFactoryLabelProvider delegate) {
		super(delegate);
	}

	def dispatch String text(Object obj) {
		return null
	}

	def dispatch String text(ContractDefinition contract) {
		contract.name
	}

	def dispatch String text(VariableDefinition it) {
		name + ": " + type.name
	}

	def dispatch String text(EventDefinition event) {
		event.name + " : event"
	}

	def dispatch String text(Parameter param) {
		if (param.name !== null) {
			param.name + " : " + param.typeSpecifier.name
		} else {
			param.typeSpecifier.name
		}
	}

	def dispatch String text(IndexParameter param) {
		param.name + " : " + param.typeSpecifier.name
	}

	def dispatch String text(FunctionDefinition it) {
		val buildInModifiers = modifier
			.filter(BuildInModifier)
			.filter[isVisibility]
			.map[type.getName.toVisibilityNotation]
			.join(" ")

		val functionModifier = modifier
			.filter(BuildInModifier)
			.filter[!isVisibility]
			.map[type.getName.toLowerCase]
			.join(" ")

		val returnType = if (returnParameters.isEmpty) {
				"void"
			} else {
				returnParameters.map[type.name].join(",")
			}
		
		
		return '''�buildInModifiers� �name�(�parameters.map[type.name].join(",")�)�IF !functionModifier.empty�[�functionModifier�]�ENDIF�: �returnType�'''
	}
	
	def dispatch boolean isVisibility(Modifier modifier) {
		false;
	}

	def dispatch boolean isVisibility(BuildInModifier modifier) {
		modifier.type === FunctionModifier.PUBLIC || modifier.type === FunctionModifier.INTERNAL ||
			modifier.type === FunctionModifier.EXTERNAL || modifier.type === FunctionModifier.PRIVATE
	}

	def dispatch String text(BuildInModifier modifier) {
		modifier.toString
	}

	def dispatch String text(FunctionModifier modifier) {
		modifier.getName
	}

	def dispatch String text(MappingTypeSpecifier specifier) {
		val key = specifier.key.name
		val value = specifier.value.name
		return "(" + key + " => " + value + ")"
	}

	def dispatch String text(ArrayTypeSpecifier specifier) {
		specifier.type.name + "[]"
	}

	def dispatch String text(TypeSpecifier specifier) {
		specifier.type.name;
	}

	def dispatch String text(Type type) {
		type.name;
	}

	def String toVisibilityNotation(Visibility visibility) {
		visibility.getName.toVisibilityNotation

	}

	def String toVisibilityNotation(String name) {
		switch (name) {
			case "PUBLIC": {
				return "+"
			}
			case "PRIVATE": {
				return "-"
			}
			case "INTERNAL": {
				return "~"
			}
			default: {
				return name
			}
		}
	}
	
	def private getName (TypeSpecifier it) {
		type.name
	}


	def dispatch String image(Object obj) {
		return null
	}

	def dispatch String image (ContractDefinition it) {
		"contract.png"
	}

	def dispatch String image (VariableDefinition it) {
		"variable.gif"
	}

	def dispatch String image (FunctionDefinition it) {
		"function.gif"
	}

	def dispatch String image (EventDefinition it) {
		"event.gif"
	}

	def dispatch String image (Package it) {
		"import.gif"
	}


}

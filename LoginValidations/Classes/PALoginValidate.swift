//
//  PALoginValidate.swift
//  LoginValidations
//
//  Created by Purva Pawar on 16/08/16.
//  Copyright © 2016 Poketapp. All rights reserved.
//

import Foundation
import UIKit
class PALoginValidate: NSObject  {
    
    
     static var textFieldArray: [UITextField]!
    
    enum UsernameStyle:String {
        case USERNAME ,EMAIL, PHONENUMBER
        
    }
    
    
    class func validatePasswords(textFromField:String ,minCount:Int , maxCount:Int, isStrictPassword:Bool) -> Bool
    {
        if isStrictPassword
        {
            if validatePasswordforLength(textFromField, minLegth: minCount, maxLength: maxCount)
            {
                return validateStrictPassword(textFromField)
            }
            else
            {
                return false
            }
        }
        else
        {
            return validatePasswordforLength(textFromField, minLegth: minCount, maxLength: maxCount)
        }
    }
    
    
    class func validateEmailAndUsername(textFromField:String, forStyle:UsernameStyle) -> (Bool)
    {
        switch forStyle.rawValue {
        case UsernameStyle.USERNAME.rawValue:
            return isValidUserName(textFromField)
        case UsernameStyle.EMAIL.rawValue:
            return isValidEmail(textFromField)
        case UsernameStyle.PHONENUMBER.rawValue:
            return isValidPhoneNumber(textFromField)
        default:
            return isValidEmail(textFromField)
        }
        
        
    }
    
    
    class func validatePasswordforLength(textFromField:String,minLegth:Int , maxLength:Int ) -> Bool
    {
        if textFromField.characters.count <= maxLength && textFromField.characters.count >= minLegth
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    class func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-àáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİĲĳĴĵĶķĸĹĺĻļĽľĿŀŁłŃńŅņŇňŉŊŋŌōŎŏŐőŒŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹźŻżŽž]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    class func isValidUserName(testStr:String) -> Bool
    {
        let emailRegEx = "\\A\\w{1,8}\\z"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    class func isValidPhoneNumber(teststr:String) -> Bool
    {
        let passwordRegex = "^((\\+)|(00))[0-9]{6,14}$"
        let passwordTest = NSPredicate (format: "SELF MATCHES %@",passwordRegex)
        
        return passwordTest.evaluateWithObject(teststr)
        
      
    }
    
    class func validateStrictPassword(textFromField:String) -> Bool
    {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$"
        let passwordTest = NSPredicate (format: "SELF MATCHES %@",passwordRegex)
        
        return passwordTest.evaluateWithObject(textFromField)
        
        
    }
    class func textFieldReturn(textField : UITextField) -> Bool
    {
      for index in 0...textFieldArray.count-1
      {
        if textFieldArray[index] == textField
        {
            if index+1 != textFieldArray.count
            {
            textFieldArray[index+1].becomeFirstResponder()
            }
            else
            {
                textFieldArray[0].becomeFirstResponder()
            }
        }
        }
        return false

    }
    
    

    
    
    
      class func setNextResponder(nextResponder:UITextField)
    {
        nextResponder.becomeFirstResponder()
        
    }
    
    
    class func moveToNextTextfield(textField:UITextField, forRange:NSRange, replaceWithString:String) -> Bool
    {
        // This allows numeric text only, but also backspace for deletes
        //        if (string.length > 0 && ![[NSScanner scannerWithString:string] scanInt:NULL])
        //        return NO;
        if replaceWithString.characters.count > 0 && !NSScanner(string: replaceWithString).scanInt(nil)
        {
            return false
        }
        let oldLength = textField.text?.characters.count
        let replacementLength = replaceWithString.characters.count
        let rangeLength = forRange.length
        
        let newLength = oldLength! - rangeLength + replacementLength
        
        // This 'tabs' to next field when entering digits
        if newLength == 1 {
            
            
            for index in 0...textFieldArray.count-1
            {
                if textFieldArray[index] == textField
                {
                    if index+1 != textFieldArray.count
                    {

                    
                    self.performSelector(#selector(self.setNextResponder(_:)), withObject: textFieldArray[index+1], afterDelay: 0.2)
                    }
                    
                }
            }
                    }
            //this goes to previous field as you backspace through them, so you don't have to tap into them individually
        else if oldLength > 0 && newLength == 0 {
            
            for index in (textFieldArray.count).stride(to: 0, by: 1)
            {
                if textFieldArray[index] == textField
                {
                    if index != 0
                    {

                    
                    self.performSelector(#selector(self.setNextResponder(_:)), withObject: textFieldArray[index-1], afterDelay: 0.1)
                    }
                }
            }
            
                 }
        
        return newLength <= 1;
    }
    
    
}

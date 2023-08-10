package com.infinite.java;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.FacesValidator;
import javax.faces.validator.Validator;
import javax.faces.validator.ValidatorException;

@FacesValidator("passwordMatchValidator")
public class PasswordMatchValidator implements Validator {

    public void validate(FacesContext context, UIComponent component, Object value) throws ValidatorException {
        String password = (String) value;
        String confirmPassword = (String) component.getAttributes().get("password");

        // Perform password matching validation
        if (password != null && confirmPassword != null && !password.equals(confirmPassword)) {
            throw new ValidatorException(
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Password does not match", null));
        }

       
    }
}

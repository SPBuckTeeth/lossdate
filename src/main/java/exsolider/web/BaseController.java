package exsolider.web;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import exsolider.util.JsonResult;

public abstract class BaseController {

	public BaseController() {
		super();
	}

	@ExceptionHandler(Exception.class)
	@ResponseBody
	public JsonResult<Object> expHandler(Exception e) {
		e.printStackTrace();
		return new JsonResult<Object>(e);
	}

}
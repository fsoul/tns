function ajax_son(file)
{
	this.xmlHttp = null;

	this.actionFile		= file;
	this.asynchronous 	= true;
	this.method 		= 'post';
	this.contentType 	= 'application/x-www-form-urlencoded';
	this.encoding 		= 'UTF-8';
	this.executeJS		= false;
	this.executeJSON	= false;
	// internal
	this.url		= '';
	this.params		= '';
	this.addsHeader		= '';

	this.vars		= new Array();

	this.responseStatus 	= new Array(2);


	this.onLoading = function() { };
  	this.onLoaded = function() { };
  	this.onInteractive = function() { };
  	this.onComplete = function() { };
  	this.onError = function() { };
	this.onFail = function() { };

	this.xmlHttpVersions = ["MSXML2.XMLHTTP.6.0",
				"MSXML2.XMLHTTP.5.0",
				"MSXML2.xmlHttp.4.0",
				"MSXML2.xmlHttp.3.0",
				"MSXML2.xmlHttp",
				"Microsoft.xmlHttp"];
	/**
	*  Create XMLHttpRequest
	**/
	this.create = function()
	{
		try
 		{
  			this.xmlHttp = new XMLHttpRequest();
 		}
 		catch(e)
 		{
			for(var i = 0; i < this.xmlHttpVersions.length && !this.xmlHttp; i++)
  			{
	   			try
   				{
    					this.xmlHttp = new ActiveXObject(this.xmlHttpVersions[i]);
   				}
   				catch (e)
				{ }
  			}
 		}

 		if(!this.xmlHttp)
		{
 			this.failed = true;
		}
	};

	this.run = function(params)
	{
		if(this.failed)
		{
			this.onFail();
		}
		else
		{
			this.params = this.encodeURL(params);
			var self = this;
			var headers = {
					'X-Requested-With': 'xmlHttpRequest',
	      				'Accept': 'text/javascript, text/html, application/xml, text/xml, */*'
				      };

			// add user headers
			if(typeof this.addsHeader == 'object')
			{
				for(var i = 0; i < this.addsHeader.length; i++)
				{
					tmp = this.addsHeader[i].split(':');
					headers[tmp[0]] = tmp[1];
				}
			}

			if(this.method == 'post')
			{
				headers['Content-Type'] = this.contentType + (this.encoding ? '; charset=' + this.encoding : '');
				headers['Content-Length'] = this.params.length;
				this.url = this.actionFile;
			}
			else
			{
				this.url = this.actionFile + '?' + this.params;
			}

			this.xmlHttp.open(this.method.toUpperCase(), this.url, this.asynchronous);

			for(var name in headers)
			{
				try
				{
					this.xmlHttp.setRequestHeader(name, headers[name]);
				}
				catch (e)
				{ }
			}
			this.xmlHttp.onreadystatechange = function()
			{
				switch (self.xmlHttp.readyState)
				{
					case 1:
						self.onLoading();
						break;
					case 2:
						self.onLoaded();
						break;
					case 3:
						self.onInteractive();
						break;
					case 4:
						self.response 		= self.xmlHttp.responseText;
						self.responseXML 	= self.xmlHttp.responseXML;
						self.responseStatus[0] 	= self.xmlHttp.status;
						self.responseStatus[1] 	= self.xmlHttp.statusText;

						if (self.executeJS && self.getHeader('Content-Type') == 'text/javascript')
						{
							self.evalJS();
						}

						if (self.responseStatus[0] == "200")
						{
							self.onComplete();
						}
						else
						{
							self.onError();
						}
						break;
				}
			};

			if(this.method == 'post')
			{
				this.xmlHttp.send(this.params);
			}
			else
			{
				this.xmlHttp.send(null);
			}

			if (!this.asynchronous)
			{
				if(this.xmlHttp.status == 200)
				{
					this.response	= this.xmlHttp.responseText;
					this.onComplete();
				}
			}
		}
	};

	/**
	*  Get header by "name"
	**/
	this.getHeader = function(name)
	{
		try
		{
			return this.xmlHttp.getResponseHeader(name);
		}
		catch(e)
		{
			return false;
		}
	};

	/**
	*  Execute Javascript
	**/
	this.evalJS = function()
	{
		try
		{
			eval(this.response);
		}
		catch(e)
		{ }
	};

	/*
	this.evalJSON = function()
	{
		//
	};
	*/
	
	this.encodeURL  = function(params)
	{
		
		varArray = params.split('&');

		for (i = 0; i < varArray.length; i++)
		{
			urlVars = varArray[i].split("=");			
			this.vars[urlVars[0]] = encodeURIComponent(urlVars[1]);
		}
		
		var tmp = new Array();
		var tmpURL = "";

		for(key in this.vars)
		{
			tmp[tmp.length] = key + "=" + this.vars[key];
		}

		return tmp.join("&");
	};

	this.create();
}
/*******************************************************************************
 * Copyright 2008, Ruboss Technology Corporation.
 * 
 * @author Dima Berastau
 * 
 * This software is dual-licensed under both the terms of the Ruboss Commercial
 * License v1 (RCL v1) as published by Ruboss Technology Corporation and under
 * the terms of the GNU General Public License v3 (GPL v3) as published by the
 * Free Software Foundation.
 *
 * Both the RCL v1 (rcl-1.0.txt) and the GPL v3 (gpl-3.0.txt) are included in
 * the source code. If you have purchased a commercial license then only the
 * RCL v1 applies; otherwise, only the GPL v3 applies. To learn more or to buy a
 * commercial license, please go to http://ruboss.com. 
 ******************************************************************************/
package org.ruboss.services.http {
  import org.ruboss.Ruboss;
  import org.ruboss.controllers.ServicesController;
  import org.ruboss.serializers.GAEXMLSerializer;
  
  /**
   * HTTPService based GAE XML-over-HTTP service provider.
   * 
   * TODO: needs to be able to upload files as well.
   */
  public class GAEHTTPServiceProvider extends XMLHTTPServiceProvider {
    
    /** service id */
    public static const ID:int = ServicesController.generateId();
    
    public function GAEHTTPServiceProvider() {
      super();
      serializer = new GAEXMLSerializer;
    }

    /**
     * @see org.ruboss.services.IServiceProvider#id
     */
    public override function get id():int {
      return ID;
    }

    // play with this
    protected override function marshallToVO(object:Object, recursive:Boolean = false, metadata:Object = null):Object {
      var vo:Object =  Ruboss.serializers.vo.marshall(object, false, metadata);
      delete vo["clazz"];
      for (var prop:String in vo) {
        if (vo[prop] == null) {
          vo[prop] = "";
        }
      }
      return vo;
    }
  }
}
FUNCTION DecodeBase64(cBase64)
    LOCAL objXML, objNode
    objXML = CREATEOBJECT("MSXML2.DOMDocument")
    objNode = objXML.createElement("base64")
    objNode.dataType = "bin.base64"
    objNode.text = cBase64
    RETURN objNode.nodeTypedValue
ENDFunc
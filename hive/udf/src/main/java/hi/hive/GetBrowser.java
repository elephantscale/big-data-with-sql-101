package hi.hive;

/**
 *
 * @author mark
 */
import eu.bitwalker.useragentutils.UserAgent;
import org.apache.hadoop.hive.ql.udf.generic.GenericUDF;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.hive.ql.exec.UDFArgumentException;
import org.apache.hadoop.hive.ql.exec.UDFArgumentLengthException;
import org.apache.hadoop.hive.ql.metadata.HiveException;
import org.apache.hadoop.hive.serde2.objectinspector.ListObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.PrimitiveObjectInspectorFactory;
import org.apache.hadoop.hive.serde2.objectinspector.PrimitiveObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.JavaStringObjectInspector;


public final class GetBrowser extends GenericUDF {

    JavaStringObjectInspector elementOI;


    @Override
    public String getDisplayString(String[] arg0) {
         return "GetBrowser"; 
    }


    @Override
    public JavaStringObjectInspector initialize(ObjectInspector[] args) throws UDFArgumentException {
        if (args.length != 1) {
            throw new UDFArgumentException("GetBrowser takes exactly one argument");
        }
        if (args[0].getCategory() != ObjectInspector.Category.PRIMITIVE
          && ((PrimitiveObjectInspector) args[0]).getPrimitiveCategory() != PrimitiveObjectInspector.PrimitiveCategory.STRING) {
            throw new UDFArgumentException("GetBrowser takes a string as a parameter");

        }
        elementOI = (JavaStringObjectInspector) args[0];
        return PrimitiveObjectInspectorFactory.javaStringObjectInspector;
    }



    @Override

    public Object evaluate(DeferredObject[] arguments) throws HiveException {
              
        String s = elementOI.getPrimitiveJavaObject(arguments[0].get());
        if (s == null) {
            return null;
        }
        return new Text(UserAgent.parseUserAgentString(s.toString()).getBrowser().getName());
    }
}

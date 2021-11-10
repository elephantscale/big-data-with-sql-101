package hi.hive;

/**
 *
 * @author mark
 */
import org.apache.hadoop.hive.ql.udf.generic.GenericUDF;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.hive.ql.metadata.HiveException;
import org.apache.hadoop.hive.ql.exec.UDFArgumentException;
import org.apache.hadoop.hive.ql.exec.UDFArgumentLengthException;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspectorFactory;
import org.apache.hadoop.hive.serde2.objectinspector.PrimitiveObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.JavaStringObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.PrimitiveObjectInspectorFactory;

public final class CountWords extends GenericUDF {

    private JavaStringObjectInspector stringOI = null;

    @Override
    public String getDisplayString(String[] arg0) {
        return "CountWords"; 
    } 

    @Override
    public ObjectInspector initialize(ObjectInspector[] args) throws UDFArgumentException {
        if (args.length != 1) {
         throw new UDFArgumentException("CountWords takes exactly one argument");
        }
        if (args[0].getCategory() != ObjectInspector.Category.PRIMITIVE
            && ((PrimitiveObjectInspector) args[0]).getPrimitiveCategory() != PrimitiveObjectInspector.PrimitiveCategory.STRING) {
            throw new UDFArgumentException("CountWords takes a string as a parameter");
        }
                                        
        // input
        stringOI = (JavaStringObjectInspector) args[0];

        return PrimitiveObjectInspectorFactory.javaIntObjectInspector;
    }
    @Override
    public Object evaluate(DeferredObject[] arguments) throws HiveException {
        String s = stringOI.getPrimitiveJavaObject(arguments[0].get());
            
        if (s == null) {
            return null;
        }
        String line = s.toString();
        String[] words = line.split("\\W");
        return new Text(Integer.toString(words.length));
    }
}

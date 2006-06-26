/**
 * @author Ron Bodkin with code drawn from Matthew Webster's example posted to aj-users 1/28/2005
 */
package org.codehaus.ajlib.util.tracing;

/**
 * Typical idiom of log4j tracing of method execution: trace to a different logger for
 * each type.
 */
public abstract aspect Log4jExecutionTracing extends ExecutionTracing pertypewithin(Traced) {
	protected interface Traced {}
	
	public pointcut scope() : within(Traced+);
	
	//TODO: test, e.g., what if staticinitialization of a type when tracing something?!
    before(): staticinitialization(*) && inScope() {
        String name = thisJoinPointStaticPart.getSignature().getDeclaringTypeName();
        tracer = new Log4jTracer(name);
	}
}

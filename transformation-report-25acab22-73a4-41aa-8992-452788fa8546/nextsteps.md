# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it to a long-term support (LTS) release.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the core functionality to confirm there are no runtime exceptions that would not have been caught at compile time.

### 5. Execute Existing Tests

If the solution contains a test project, run the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and address them before proceeding further.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **File system paths**: Ensure no hardcoded Windows-style paths (e.g., backslashes) are used. Use `Path.Combine` instead.
- **Configuration**: Verify that `Web.config` or `App.config` settings have been properly migrated to `appsettings.json` and are being read correctly via `IConfiguration`.
- **Authentication/Authorization**: If the project uses ASP.NET membership or Windows Authentication, confirm the equivalent middleware is configured correctly in `Program.cs` or `Startup.cs`.
- **Session and HttpContext**: Confirm that any usage of `HttpContext.Current` has been replaced with dependency-injected `IHttpContextAccessor`.

### 7. Static File and Middleware Configuration

If this is a web project, verify that static files, routing, and middleware are configured correctly in `Program.cs`:

```csharp
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
```

### 8. Database Connectivity

If the project uses Entity Framework or direct database access, confirm the connection string in `appsettings.json` is correct and that the database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is referenced and up to date.

Run a quick connectivity check by exercising a data-driven page or endpoint during local testing.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is complete and well-formed:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all expected files, static assets, and configuration files are present.

### 10. Deploy to Target Environment

Copy the published output to the target hosting environment. Ensure the target machine has the correct .NET runtime installed:

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download). Start the application on the target environment and perform a final round of smoke testing against the deployed instance.
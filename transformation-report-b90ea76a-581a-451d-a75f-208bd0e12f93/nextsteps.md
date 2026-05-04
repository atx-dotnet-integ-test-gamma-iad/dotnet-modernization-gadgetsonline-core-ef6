# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or another actively supported version and not a legacy `net4x` framework.

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences between the legacy .NET Framework and the new cross-platform .NET runtime.

### 5. Check for Runtime-Specific API Usage

Even without build errors, certain APIs behave differently or are unavailable at runtime on cross-platform .NET. Review the code for usage of the following:

- `System.Web` namespaces (not available outside of Windows/ASP.NET Core migration)
- `HttpContext` usage outside of ASP.NET Core patterns
- Windows Registry access (`Microsoft.Win32.Registry`)
- COM interop or P/Invoke calls targeting Windows-only libraries
- `AppDomain.CreateDomain` (not supported in .NET Core and later)

### 6. Test Application Behavior Locally

Start the application locally and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the primary user flows of the application, such as browsing products, adding items to a cart, and completing a purchase, to confirm end-to-end behavior is intact.

### 7. Verify Configuration Files

Ensure that `appsettings.json` (or `appsettings.Release.json`) contains all configuration values that were previously held in `Web.config` or `App.config`. Pay particular attention to:

- Database connection strings
- Application-specific settings keys
- Authentication or authorization configuration

### 8. Check Database Connectivity

If the application uses a database, confirm that the connection string is valid and that the application can connect and perform queries correctly in the new environment. If Entity Framework is in use, verify that migrations are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Review Static Files and wwwroot

If this is a web application, confirm that static assets such as CSS, JavaScript, and images are located under the `wwwroot` folder and are being served correctly by the ASP.NET Core static file middleware.

### 10. Publish the Application

Once the above steps are validated, publish the application to confirm the output is complete and well-formed:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assemblies, and assets are present before deploying to the target environment.
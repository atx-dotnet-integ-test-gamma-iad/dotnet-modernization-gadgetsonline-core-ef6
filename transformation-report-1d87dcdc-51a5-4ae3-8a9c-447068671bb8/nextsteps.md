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

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its core functionality to identify any runtime errors that would not surface at build time.

### 5. Review Replaced or Removed APIs

Check for any usages of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in .NET Core or later
- `HttpContext` and related types, which may behave differently
- Windows-specific APIs such as the registry, WCF, or `System.Drawing` (without the compatibility package)
- Configuration APIs (`ConfigurationManager` vs. `Microsoft.Extensions.Configuration`)

### 6. Verify Static Files and wwwroot

If the project is an ASP.NET Core web application, confirm that static assets (CSS, JavaScript, images) have been placed in the `wwwroot` folder and that the middleware is configured correctly in `Program.cs` or `Startup.cs`:

```csharp
app.UseStaticFiles();
```

### 7. Validate Database Connectivity

If the application uses a database, confirm the connection string in `appsettings.json` is correct and that any Entity Framework migrations are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Execute Unit Tests

If there are test projects in the solution, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and resolve the underlying issues before proceeding.

### 9. Publish the Application

Once the application has been validated locally, publish it to verify the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all required files are present, then deploy the contents to the target environment.
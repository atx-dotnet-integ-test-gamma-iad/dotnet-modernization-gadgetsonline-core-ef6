# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types, deprecated APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the framework moniker is appropriate (e.g., `net8.0` rather than a Windows-specific TFM unless Windows-only APIs are required).

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that functionality has been preserved after the migration.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect regressions introduced during migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usage (not available in cross-platform .NET)
- `HttpContext` and related types (replaced by `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows Registry or Windows-specific interop calls
- `BinaryFormatter` (removed in .NET 9, deprecated in earlier versions)

### 7. Verify Static Assets and Configuration Files

Confirm that files such as `appsettings.json`, `wwwroot` contents, and any view files have been carried over correctly and are functioning as expected at runtime.

### 8. Validate Database Connectivity

If the application uses a database, verify that the connection strings in `appsettings.json` are correct and that the application can connect and perform operations as expected. If Entity Framework is in use, confirm that migrations are up to date:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once local validation is complete, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.